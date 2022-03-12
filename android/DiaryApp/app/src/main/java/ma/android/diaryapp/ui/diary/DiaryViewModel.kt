package ma.android.diaryapp.ui.diary

import android.app.Application
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.annotation.WorkerThread
import androidx.lifecycle.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import ma.android.diaryapp.data.domain.Diary
import ma.android.diaryapp.database.room.DiaryRoomDatabase
import ma.android.diaryapp.repository.DiaryRepository

class DiaryViewModel(application: Application): AndroidViewModel(application) {

    private val diaryRepository: DiaryRepository
    val pagesOfDiary: LiveData<List<Diary>>

    init {
        val diaryDao = DiaryRoomDatabase.getDatabase(application, viewModelScope).diaryDao()
        diaryRepository = DiaryRepository(diaryDao)
        pagesOfDiary = diaryRepository.pagesOfDiary
    }

    fun update(entity: Diary) = viewModelScope.launch(Dispatchers.IO) {
            diaryRepository.update(entity)

    }

    fun delete(entity: Diary)  = viewModelScope.launch(Dispatchers.IO) {
            diaryRepository.delete(entity)
    }

}