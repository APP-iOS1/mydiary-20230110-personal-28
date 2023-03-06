# MyBullet

## 주요기능

- Date와 Calender를 사용하여 날짜와 시각을 등록할 수 있는 일정 앱을 만들고자 하였습니다.
- ScrollViewReader를 사용하여 현재 시각에 자동으로 스크롤되어 보여집니다.
- 할일 추가 시 사용자가 선택한 색상에따라 HeaderView의 색상이 점진적으로 퍼지면서 바뀌는 애니메이션을 적용하였습니다.

## 특징

- singleton 패턴을 적용하여, 로그인한 유저의 정보를 담고 있는 객체에 빠르게 접근할 수 있도록 했습니다.
- extension을 활용하여 Date, Calender, View, String 등에 새로운 메서드를 추가하였습니다.
- Custom Font를 적용해보았습니다.
- Error 객체를 enum으로 구현하여 각각의 에러사항에 대해 알맞은 에러메세지가 Toast로 보여질 수 있도록 하였습니다.
- Firebase의 Authentication을 활용하여 로그인을 구현하였습니다.
- Async/Await를 활용하여 동시성을 적용하였습니다.
- 사용자가 Response가 들어오기 전에 앱을 조작할 수 없도록 Loading View를 삽입하였습니다.
