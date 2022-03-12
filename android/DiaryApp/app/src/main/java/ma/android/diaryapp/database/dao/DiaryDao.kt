package ma.android.diaryapp.database.dao

import androidx.lifecycle.LiveData
import androidx.room.*
import ma.android.diaryapp.data.domain.Diary

@Dao
interface DiaryDao {

    @Query("SELECT * FROM diary_table")
    fun findAll(): LiveData<List<Diary>>

    @Insert
    fun insert(diary: Diary)

    @Update
    fun update(diary: Diary)

    @Delete
    fun delete(diary: Diary)
}