package ma.android.diaryapp

import android.app.AlertDialog
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import ma.android.diaryapp.databinding.ActivityLoginBinding
import ma.android.diaryapp.databinding.FragmentDiaryBinding
import ma.android.diaryapp.ui.login.LoginViewModel

class LoginActivity : AppCompatActivity() {

    private val loginViewModel : LoginViewModel by viewModels()
   // private lateinit var loginViewModel: LoginViewModel
    private var _binding: ActivityLoginBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // login binding
        _binding = ActivityLoginBinding.inflate(layoutInflater)

        setContentView(binding.root)

        val username = binding.editTextTextEmailAddress.text
        val password = binding.editTextTextPassword.text

        // login
        val loginButton : Button = binding.loginButton
        loginButton.setOnClickListener{

            val ok = loginViewModel.login(username.toString(), password.toString())
            if(ok)
                openMain()
            else {
                // alertDialog
                val dialogBuilder = AlertDialog.Builder(this)

                // set message of alert dialog
                dialogBuilder.setMessage("Wrong email or password!")
                    // if the dialog is cancelable
                    .setCancelable(false)
                    // negative button text and action
                    .setNegativeButton(
                        "OK",
                        DialogInterface.OnClickListener { dialog, _ ->
                            dialog.cancel()
                        })

                // create dialog box
                val alert = dialogBuilder.create()

                // set title for alert dialog box
                alert.setTitle("Error")

                // show alert dialog
                alert.show()
            }
        }
    }

    private fun openMain() {
        startActivity(Intent(this, MainActivity::class.java))
    }

    override fun onDestroy() {
        super.onDestroy()
        _binding = null
    }

}