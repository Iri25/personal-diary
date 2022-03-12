package ma.android.diaryapp.ui.login

import androidx.lifecycle.ViewModel

import ma.android.diaryapp.repository.UserRepository

class LoginViewModel : ViewModel() {

    private val userRepository = UserRepository()

    fun login(username : String, password : String) : Boolean {
        return userRepository.login(username, password)
    }
}