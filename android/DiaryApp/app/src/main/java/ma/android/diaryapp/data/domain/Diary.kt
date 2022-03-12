package ma.android.diaryapp.data.domain

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "diary_table")
data class Diary (@PrimaryKey
    @ColumnInfo(name = "day")
    var day: String,

    @ColumnInfo(name = "userId")
    val userId: String,

    @ColumnInfo(name = "color")
    var color: String,

    @ColumnInfo(name = "summary")
    var summary: String,

    @ColumnInfo(name = "text")
    var text: String
    ) {

    override fun toString(): String {
        return "Emotion: " + color + "\n" +
                "Summary: " + summary + "\n" +
                "Text: " + text + "\n"
    }
}
