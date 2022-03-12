package ma.android.diaryapp.repository

import ma.android.diaryapp.data.domain.User

class UserRepository{

    private val userLogin = User("iri25@gmail.com", "irina25")

     fun login(username : String, password : String) : Boolean {
         return username == userLogin.email && password == userLogin.password
    }
}