BUDGITO API

budgito.herokuapp.com/api/accounts/

' ' - signup a user, user can't login yet. A verification mail is sent to User.
        User clicks on the link and is being activated
        
        -Credentials needed: 
        username, email, first_name, last_name, password, confirm_password
        
'activate/' - When the user clicks the link the user's id is collected as well as the token.
             Link in Mail looks like 
             http://budgito.herokuapp.com/activate/<user_id> as bytes/token
             
                -Needed
                user id and token gotten from link and passed through this endpoint
                
'token/' - to login a user, the user credentials are passed in here and an access_token is gotten
            and this token can be used in the 'me/' endpoint to get their profile
            
            Needed
            username and password
            
'me/' - used with the access token to get my profile
        get: with access token to get the profile
        put: with access token to update profile