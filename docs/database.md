# 데이터베이스

많은 개발자들이 Firestore 를 선호하는데 상세한 필터링과 Extensions 의 지원 등 다양한 활용성이 높기 때문이다. Realtime Database 는 구조가 단순하여 사용하기 쉽고 입/출력 속도가 빠르며, 저렴하다.

`하우스`에서는 Firestore 와 Realtime Database 를 같이 사용하는데, 어떤 데이터베이스를 사용할지 정하는 규칙은 이렇다.

1. 입/출력이 매우 빈번한가? 예를 들어, 주요 화면에서 채팅 친구 목록이나, 글 목록 등을 ListView 형태로 표현하면, 사용자들이 빈번하게 스크롤 할 것이고, 사용자가 많아 질수록 비용문제가 크게 발생한다.
2. 단순한 입출력인가? 사용자의 활동 로그(페이지 이동, 좋아요, 채팅 등)를 작성하는 경우, 한 사용자당 하루에 1000개 정도의 로그가 쌓인다고 하면, 1만명의 사용자가 한 달간 사용을 하면, 3천 만개의 레코드가 발생하고, 또 로그를 바탕으로 타임라인 등을 보여준다면, 엄청난 양의 레코드를 입출력해야 한다.

이 처럼, 단순하고 빈번한 입/출력의 경우 Realtime Database 를 사용하고 그 외에는 Firestore 를 사용한다. 예를 들면 사용자 정보 같은 경우, 화면에 목록으로 표시를 하거나 검색을 하는 등 매우 빈번한 입/출력을 한다. 하지만, 단순한 입출력이 아니며 복잡한 필터링을 해야 할 수 있으므로 Firestore 를 사용한다. 또 다른 예로 채팅 메시지의 경우 특정 채팅방에 종속되는 것으로 별도의 필터링이 필요하지 않다. 채팅 메시지 자체를 카테고리 별로 검색하거나 특정 사용자의 채팅 메시지를 따로 목록하지 않는다. 그래서 Realtime Database 로 저장한다. 코멘트도 마찬가지이다. 하지만 글의 경우는 Firestore 에 저장하는데, 전체 목록, 카테고리 별로 목록, 특정 사용자의 글만 목록 등 다양하게 검색이 필요할 수 있으므로 Firestore 를 사용한다.

특히, Realtime Database 를 사용하는 경우, 필요한 라이브러리들을 잘 만들어 놓아서, 직접 Realtime Database 를 액세스 할 필요 없도록 한다. 즉, 개발자가 편하게 쓸 수 있도록 해 준다.



## 채팅

### 채팅방

저장소: Firestore

### 채팅메시지

저장소: Realtime Database



## 카테고리

글 카테고리이다.

저장소: Firestore


## 글

저장소: Firestore


## 코멘트

저장소: Realtime Database


## 친구

저장소: Firestore


## 활동로그

저장소: Realtime Database

## 액션로그

주요 액션을 기록하는 것이다. 이 액션 로그를 통해서 하루에 글 쓰기 회수 제한, 또는 특정 조건에 따라서 좋아요, 채팅 등의 제한 등등을 할 수 있다.


저장소: Realtime Database


## 북마크

저장소: Realtime Database


## 모임

모임은 카페 또는 동호회의 성격을 가지며, 회원 가입을 통해서 해당 카페의 글, 채팅을 사용 할 수 있다. 또한 오프라인 이벤트 참여 신청 기능도 있다.

저장소: Firestore

## 사용자 설정

사용자 별 개인 설정이다.

저장소: Firestore


