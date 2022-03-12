package ma.android.diaryapp.repository

import androidx.annotation.WorkerThread
import androidx.lifecycle.LiveData
import ma.android.diaryapp.data.domain.Diary
import ma.android.diaryapp.database.dao.DiaryDao


class DiaryRepository(private val diaryDao: DiaryDao) {

    var pagesOfDiary: LiveData<List<Diary>> = diaryDao.findAll()

    @Suppress("RedundantSuspendModifier")
    @WorkerThread
    suspend fun save(diary: Diary) {
        diaryDao.insert(diary)
    }

    @Suppress("RedundantSuspendModifier")
    @WorkerThread
    suspend fun update(diary: Diary) {
        diaryDao.update(diary)
    }

    @Suppress("RedundantSuspendModifier")
    @WorkerThread
    suspend fun delete(diary: Diary) {
        diaryDao.delete(diary)
    }

}

