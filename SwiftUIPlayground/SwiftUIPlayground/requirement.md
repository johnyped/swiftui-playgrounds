### Purpose 
Create LoginView with contain 2 View Secton

View Section 1 : Login With Email and Password , Login button
- When tap Login Button will disble Button for temporary , and triger active show Progress view at Button when tapped
- Prepare calling of async func to call auth API Service , place an exaple code to help replace easier
- Login Success : Route To Empty HomeView
- Login Fail : show error SheetView
- Calling on Auth API Spec
POST http://host/api/v4/auth/login
Json body
{
    "username" : "example@email.com",
    "password" : "12345678"
}
Json Response 
{
    "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIyMGQ0MjJjNjVhOWM4MDVhMGQ5MGRjNzU3ZTQ1MmZmZCIsImlhdCI6MTc1MjgxNzg1OCwiZXhwIjoxNzUyODE4NzU4LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.pklq332x7Z-mbhkv6vc1t_Rt5lBuit5q9UR_0zGmMfU",
    "refresh_token": "d6f8b73993b104c1ffe06f290826d98e"
}
- store access_token on userDefault 
- checking token by calling to 
GET http://host/api/v4/hotels
Header["Authorization" : "Bearer {{access_token}}"]
Response HTTP: 200

View Section 2 : Login with Apple ID
- Login With Apple Button
- When tapped connect to Apple Login Framework , Authrorize , Approve
- Get response of Apple credential code
- Calling Apple Login API spec
 POST http://host/api/v4/auth/apple-login
 Json body
{
  "code": "<string>", // get from apple meta data
  "first_name": "<string>", // get from apple meta data if exist else fill ""
  "last_name": "<string>", // get from apple meta data if exist else fill ""
  "email": "<string>" // get from apple meta data if exist else fill ""
}
Json Response 
{
    "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIyMGQ0MjJjNjVhOWM4MDVhMGQ5MGRjNzU3ZTQ1MmZmZCIsImlhdCI6MTc1MjgxNzg1OCwiZXhwIjoxNzUyODE4NzU4LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.pklq332x7Z-mbhkv6vc1t_Rt5lBuit5q9UR_0zGmMfU",
    "refresh_token": "d6f8b73993b104c1ffe06f290826d98e"
}
- store access_token on userDefault 
- checking token by calling to 
GET http://host/api/v4/hotels
Header["Authorization" : "Bearer {{access_token}}"]
Response HTTP: 200
