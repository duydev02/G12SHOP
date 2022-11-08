package com.g12shop.service.impl;

import org.springframework.stereotype.Service;

<<<<<<< Updated upstream
=======
import com.g12shop.Util.UserNotFoundExcepion;
import com.g12shop.config.EncoderConfig;
import com.g12shop.entity.Accounts;
import com.g12shop.repository.AccountsRepo;
>>>>>>> Stashed changes
import com.g12shop.service.AccountsService;

@Service
public class AccountsServiceImpl implements AccountsService {
<<<<<<< Updated upstream

=======
	@Autowired
	private AccountsRepo repo;
	
	@Autowired
	private EncoderConfig encoderConfig;

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
>>>>>>> Stashed changes
}
