import 'package:diary_app/domain/diary.dart';
import 'package:diary_app/repository/diary_repository.dart';

class DiaryService implements DiaryRepository{


  @override
  List<Diary> pagesOfDiary = [
    Diary("iri25@gmail.com", "2021-11-01", "Blue", "Yes", "Good"),
    Diary("iri25@gmail.com", "2021-11-08", "Yellow", "No", "Bad")
  ];

  DiaryRepository diaryRepository = DiaryRepository([
    Diary("iri25@gmail.com", "2021-11-01", "Blue", "Yes", "Good"),
    Diary("iri25@gmail.com", "2021-11-08", "Yellow", "No", "Bad")
  ]);


  @override
  Diary findOne(String id){
    return diaryRepository.findOne(id);
  }

  @override
  List<Diary> findAll() {
    return diaryRepository.findAll();
  }

  @override
  void save(Diary diary) {
    diaryRepository.save(diary);
  }

  @override
  void update(Diary diary) {
    diaryRepository.update(diary);
  }

  @override
  void delete(Diary diary) {
    diaryRepository.delete(diary);
  }

}