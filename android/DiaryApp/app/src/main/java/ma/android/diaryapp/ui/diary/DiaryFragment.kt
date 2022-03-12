package ma.android.diaryapp.ui.diary

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Build
import android.os.Bundle
import android.text.Editable

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import androidx.annotation.RequiresApi

import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import ma.android.diaryapp.ui.utils.DatePickerFragment
import ma.android.diaryapp.MainActivity
import ma.android.diaryapp.data.domain.Diary

import ma.android.diaryapp.databinding.FragmentDiaryBinding

import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*

class DiaryFragment : Fragment() {

    // ViewModel
    private lateinit var diaryViewModel: DiaryViewModel
    private var _binding: FragmentDiaryBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        diaryViewModel = ViewModelProvider(this)[DiaryViewModel::class.java]

        _binding = FragmentDiaryBinding.inflate(inflater, container, false)

        return binding.root
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentDiaryBinding.bind(view)

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

                        // date to search
                        val dateFormat = date?.removeSuffix(" ")
                        val format = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH)
                        val dateToSearch = LocalDate.parse(dateFormat.toString(), format)

                        // item searched
                        var item = Diary("", "", "", "", "")
                        diaryViewModel.pagesOfDiary.observe(this@DiaryFragment, Observer {
                            pagesOfDiary -> pagesOfDiary.forEach {
                              if(it.day == dateToSearch.toString()){
                                  item = it
                              }
                        }
                        })

                        // context
                        val context = context as MainActivity

                        /*
                        // listView
                        val list = mutableListOf(item)
                        val arrayAdapter = ArrayAdapter(context, R.layout.simple_list_item_1, list)
                        val listView = listViewDiaries

                        // show listView
                        listView.adapter = arrayAdapter

                        // change dates
                        listView.setOnItemClickListener {parent, view, position, _ ->
                            val element = parent.getItemAtPosition(position)
                        }
                        */

                        // show editText
                        editTextColor.text = Editable.Factory.getInstance()
                            .newEditable(item.color)
                        editTextSummary.text = Editable.Factory.getInstance()
                            .newEditable(item.summary)
                        editTextText.text = Editable.Factory.getInstance()
                            .newEditable(item.text)

                        buttonDelete.setOnClickListener {

                            // alertDialog
                            val dialogBuilder = AlertDialog.Builder(context)

                            // set message of alert dialog
                            dialogBuilder.setMessage("Are you sure you want to delete?")
                                // if the dialog is cancelable
                                .setCancelable(false)
                                // positive button text and action
                                .setPositiveButton(
                                    "Yes",
                                    DialogInterface.OnClickListener { dialog, id ->
                                        dialog.apply {
                                            diaryViewModel.delete(item)

                                            // delete list
                                            //listView.removeAllViewsInLayout()


                                            // delete editText
                                            editTextColor.text = Editable.Factory.getInstance()
                                                .newEditable("")
                                            editTextSummary.text = Editable.Factory.getInstance()
                                                .newEditable("")
                                            editTextText.text = Editable.Factory.getInstance()
                                                .newEditable("")
                                        }
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
                            alert.setTitle("Confirm Delete")
                            // show alert dialog
                            alert.show()
                        }

                        buttonUpdate.setOnClickListener {

                            // alertDialog
                            val dialogBuilder = AlertDialog.Builder(context)

                            // set message of alert dialog
                            dialogBuilder.setMessage("Are you sure you want to update?")
                                // if the dialog is cancelable
                                .setCancelable(false)
                                // positive button text and action
                                .setPositiveButton(
                                    "Yes",
                                    DialogInterface.OnClickListener { dialog, _ ->
                                        dialog.apply {
                                           diaryViewModel.update(item)


                                            // update editText
                                            item.color = editTextColor.text.toString()
                                            item.summary = editTextSummary.text.toString()
                                            item.text = editTextText.text.toString()

                                        }
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
                            alert.setTitle("Save Changes?")
                            // show alert dialog
                            alert.show()
                        }
                    }
                }
                // show calendar
                datePickerFragment.show(supportFragmentManager, "DatePickerFragment")
            }
        }
    }

    // DestroyView
    override fun onDestroyView() {
        super.onDestroyView()
            _binding = null
    }

}
