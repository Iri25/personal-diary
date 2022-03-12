package ma.android.diaryapp.database.room

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import ma.android.diaryapp.data.domain.Diary
import ma.android.diaryapp.database.dao.DiaryDao

@Database(entities = [Diary::class], version = 1)
abstract class DiaryRoomDatabase: RoomDatabase() {

    abstract fun diaryDao(): DiaryDao

    companion object {
        @Volatile
        private var INSTANCE: DiaryRoomDatabase? = null

        fun getDatabase(context: Context, scope: CoroutineScope): DiaryRoomDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    DiaryRoomDatabase::class.java,
                    "word_database"
                )
                    // Wipes and rebuilds instead of migrating if no Migration object.

                    // destructive migration to our database.
                    .fallbackToDestructiveMigration()
                    // build our database.
                    .build()
                INSTANCE = instance
                // return instance
                instance
            }
        }
    }
}

