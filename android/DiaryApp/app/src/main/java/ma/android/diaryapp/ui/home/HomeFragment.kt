package ma.android.diaryapp.ui.home

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.annotation.RequiresApi
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import ma.android.diaryapp.ui.utils.DatePickerFragment
import ma.android.diaryapp.MainActivity
import ma.android.diaryapp.R
import ma.android.diaryapp.data.domain.Diary
import ma.android.diaryapp.databinding.FragmentHomeBinding
import androidx.lifecycle.Observer
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*

class HomeFragment : Fragment() {

    private lateinit var homeViewModel : HomeViewModel
    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!

    private lateinit var t : View
    private val colors = arrayOf("Green", "Orange", "Pink", "Yellow", "Red", "Blue")

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        homeViewModel = ViewModelProvider(this)[HomeViewModel::class.java]
        _binding = FragmentHomeBinding.inflate(inflater, container, false)

        t = inflater.inflate(R.layout.fragment_home, container, false)
        val spinner = t.findViewById<Spinner>(R.id.positionSpinner)
        spinner?.adapter = activity?.applicationContext?.let {
            ArrayAdapter(it, R.layout.support_simple_spinner_dropdown_item, colors) }
                as SpinnerAdapter
        spinner?.onItemSelectedListener = object : AdapterView.OnItemSelectedListener{
            override fun onNothingSelected(parent: AdapterView<*>?) {
                println("ERROR")
            }

            override fun onItemSelected(parent: AdapterView<*>?,
                                        view: View?,
                                        position: Int,
                                        id: Long) {
                val type = parent?.getItemAtPosition(position).toString()
                Toast.makeText(activity,type, Toast.LENGTH_LONG).show()
                println(type)
            }

        }

        return t
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentHomeBinding.bind(view)

        binding.apply {
            // calendar
            pickerDateButton.setOnClickListener {
                // create new instance of DatePickerFragment
                val datePickerFragment = DatePickerFragment()
                val supportFragmentManager = requireActivity().supportFragmentManager

                // we have to implement setFragmentResultListener
                supportFragmentManager.setFragmentResultListener(
                    "REQUEST_KEY",
                    viewLifecycleOwner
                ) { resultKey, bundle ->
                    if (resultKey == "REQUEST_KEY") {
                        val date = bundle.getString("SELECTED_DATE")
                        editDatePicker.text = date

                        // save button
                        buttonSave.setOnClickListener {
                            val dateFormat = date?.removeSuffix(" ")
                            val format = DateTimeFormatter.ofPattern("yyyy-MM-dd",
                                                                        Locale.ENGLISH)
                            val day = LocalDate.parse(dateFormat.toString(), format).toString()
                            val color = positionSpinner.selectedItem.toString()
                            val summary = editTextSummaryHome.text.toString()
                            val text = editTextTextHome.text.toString()

                            // item searched
                            var item = Diary("", "", "", "", "")
                            homeViewModel.pagesOfDiary.observe(this@HomeFragment, Observer {
                                    pagesOfDiary -> pagesOfDiary.forEach {
                                if(it.day == day.toString()){
                                    item = it
                                }
                            }
                            })

                            val itemSave = Diary(day, "iri25@gmail.com", color, summary, text)

                            // context
                            val context = context as MainActivity

                            // check date
                            if(item.day == "" && day <= LocalDate.now().toString()){

                                // alertDialog
                                val dialogBuilder = AlertDialog.Builder(context)

                                // set message of alert dialog
                                dialogBuilder.setMessage("Are you sure you want to save?")
                                // if the dialog is cancelable
                                    .setCancelable(false)
                                    // positive button text and action
                                    .setPositiveButton(
                                        "Yes",
                                        DialogInterface.OnClickListener { dialog, _ ->
                                            dialog.apply { homeViewModel.save(itemSave) }
                                        })
                                    // negative button text and action
                                    .setNegativeButton(
                                        "No",
                                        DialogInterface.OnClickListener { dialog, _ ->
                                            dialog.cancel()
                                        })

                                // create dialog box
                                val alert = dialogBuilder.create()
                                // set title for alert dialog box
                                alert.setTitle("Confirm Save")
                                // show alert dialog
                                alert.show()

                            }
                            if (day > LocalDate.now().toString()) {

                                    // alertDialog
                                    val dialogBuilder = AlertDialog.Builder(context)

                                    // set message of alert dialog
                                    dialogBuilder.setMessage("You cannot add a future diary page!")
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
                }
                // show datePicker
                datePickerFragment.show(supportFragmentManager, "DatePickerFragment")
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}