import 'package:diary_app/domain/diary.dart';

class DiaryRepository {

  List<Diary> pagesOfDiary ;
  DiaryRepository(this.pagesOfDiary);


  Diary findOne(String id){
    Diary diary = Diary("", "2021-01-01", "", "", "");

    for (int i = 0; i < pagesOfDiary.length; i++){
      if(pagesOfDiary[i].day == id) {
        diary = pagesOfDiary[i];
      }
    }
    return diary;
  }

  List<Diary> findAll() {
    return pagesOfDiary;
  }

  void save(Diary diary) {
    pagesOfDiary.add(diary);
  }

  void update(Diary diary) {
    Diary diaryUpdate = findOne(diary.day);

    diaryUpdate.color = diary.color;
    diaryUpdate.summary = diary.summary;
    diaryUpdate.text = diary.text;
  }

  void delete(Diary diary) {
    Diary diaryDelete = findOne(diary.day);

    pagesOfDiary.remove(diaryDelete);
  }

}