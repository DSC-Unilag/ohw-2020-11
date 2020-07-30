BUDGITO API

mini doc

accounts or authentication - /api/accounts/
- signup without confirmation: '/'

    |- Credentials needed 
        
        |- username, email, first_name, last_name, password, confirm_password

- activation: 'activate/'

- gettings user's token: 'token/'
    
    |- for logging user in. Expires in 72 Hours
    
- my profile: 'me/'
