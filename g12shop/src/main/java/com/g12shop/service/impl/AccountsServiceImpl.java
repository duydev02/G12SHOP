package com.g12shop.service.impl;

import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.g12shop.config.EncoderConfig;
import com.g12shop.entity.Accounts;
import com.g12shop.entity.Roles;
import com.g12shop.repository.AccountsRepo;
import com.g12shop.service.AccountsService;

import com.g12shop.service.RolesService;

import net.bytebuddy.utility.RandomString;

import com.g12shop.Util.UserNotFoundExcepion;


@Service
@Transactional(rollbackOn = { Exception.class, Throwable.class })
public class AccountsServiceImpl implements AccountsService {

	@Autowired
	private AccountsRepo repo;
	
	@Autowired
	private EncoderConfig encoderConfig;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private RolesService rolesService;

	@Override
	public List<Accounts> findAll() {
		return repo.findAll();
	}

	@Override
	public Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion {
		Accounts accountResponse = repo.findByUsernameOrEmailAndIsEnabledAndIsDeleted(usernameOrEmail, usernameOrEmail, Boolean.TRUE, Boolean.FALSE);
		
		if(accountResponse == null) {
			throw new UserNotFoundExcepion("Account is not exists!");
		}else if(accountResponse.getIsEnabled() == false) {
			throw new UserNotFoundExcepion("Account not activated!");
		}else if(accountResponse.getIsDeleted() == true) {
			throw new UserNotFoundExcepion("Account has been deleted");
		}else {
			Boolean checkPassword = encoderConfig.passwordEncoder().matches(password, accountResponse.getHashPassword());
			return checkPassword ? accountResponse : null;
		}
	}

	@Override
	public Accounts doRegister(Accounts account) throws UserNotFoundExcepion {
		if (existsUsername(account.getUsername())) {
			throw new UserNotFoundExcepion("Account already exists!");
		} else if (existsEmail(account.getEmail())) {
			throw new UserNotFoundExcepion("Email already exists!");
		} else {
			Roles role = rolesService.findByName("user");
			account.setRoles(role);
			account.setIsEnabled(Boolean.FALSE);
			account.setIsDeleted(Boolean.FALSE);
			String password = encoderConfig.passwordEncoder().encode(account.getHashPassword());
			account.setHashPassword(password);

			String randomCode = RandomString.make(64);
			account.setVerificationCode(randomCode);
			return repo.saveAndFlush(account);
		}
	}
	
	@Override
	public void sendVerificationEmail(Accounts account, String siteURL) throws Exception {
		String subject = "Please verify your register";
		String senderName = "G12SHOP";
		String mailContent = "<p>Dear:" + account.getFullname() + ", </p>";
		mailContent += "<p>Please click the link below to cofirm your register!</p>";
		
		String verifiURL = siteURL + "/verify?verificationCode=" + account.getVerificationCode();
		mailContent += "<h1><a href = \"" + verifiURL + "\">Verification</a></h1>";
		mailContent += "<p> Thank You </p>";
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		
		helper.setFrom("lamnhps16063@fpt.edu.vn", senderName);
		helper.setTo(account.getEmail());
		helper.setSubject(subject);
		helper.setText(mailContent, true);
		
		mailSender.send(message);
	}
	
	@Override
	public Boolean verificationAccount(String verificationCode) {
		// TODO Auto-generated method stub
		Accounts account = repo.findByVerificationCode(verificationCode);
		
		if(account == null || account.getIsEnabled()) {
			return false;
		}else {
			account.setVerificationCode(null);
			account.setIsEnabled(Boolean.TRUE);
			repo.saveAndFlush(account);
			return true;
		}
	}
	
	private Boolean existsUsername(String username) {
		return repo.findByUsername(username) != null ? true : false;
	}
	
	private Boolean existsEmail(String email) {
		return repo.findByEmail(email) != null ? true : false;
	}
}
