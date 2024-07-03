# 모델하우스 이해

`모델하우스`는 Flutter 와 Firebase 를 사용하여 빠르게 앱을 구축하기 위한 패키지이다. 아름다운 UI 디자인 뿐만아니라 회원 가입, 게시판, 채팅, 소셜 기능을 모두 포함하는 완전한 소셜 앱 패키지로 매우 쉽게 사용이 가능하도록 해 주며 원하는대로 쉽게 커스터마이징을 할 수 있다.

`모델하우스`는 [FireFlutter](https://thruthesky.github.io/fireflutter/korean/)의 다음 버전이며, 본 프로젝트가 잘 진행되면 기존의 [FireFireflutter](https://thruthesky.github.io/fireflutter/korean/)를 대체하게 될 것이다.

하우스의 첫번째 버전은 FireFlutter 의 개념을 그대로 가져오고 수정, 보완하는 것인데, FireFlutter 는 Realtime Database 기반인데 개발자들이 어려워하는 경향이 있고 사용하기를 꺼려한다. 그래서, 하우스에서는 Firestore 를 메인으로 하되 꼭 필요한 부분은 Realtime Database 를 사용한다는 계획이다.



## 개요

- 누구나 참여할 수 있다.
- 라이센스는 MIT 이며, 누구든지 어떤 목적으로든 사용 할 수 있다.
- `모델하우스`를 줄여서 `하우스`라고 부른다.
- 필터링(검색)이 많이 필요한 경우 Firestore 를 사용하고 단순한 입출력의 경우 Realtime Database 를 사용한다. 특히, 단순한 입/출력이 매우 빈번한 경우, 비용적인 문제가 발생하는 데, Firestore 보다는 Realtime Database 가 제격이다. 자세한 내용은 [데이터베이스 설계](./database.md) 항목을 참고한다.
- 지원하는 플랫폼은 ANDROID, IOS, MACOS, WEB, WINDOWS 이다.
- 백엔드는 파이어베이스 함수를 사용한다. 가능한 많은 것을 플러터에서 하되, 벡엔드가 꼭 필요하면 파이어베이스 내에서 모든 처리를 하기 위해서 파이어베이스 함수를 사용한다.


## 참여 방법

가장 먼저 협업하는 방법에 대해서 배워한다. 협업을 하기 위해서는

- Git 을 알아야하고, [Dart 스타일 가이드](https://dart-ko.dev/guides/language/effective-dart),
- [Flutter 스타일 가이드](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md)을 잘 알고 있어야 한다.
- 또한 필수적으로 문서화를 잘 해야 한다. 문서화는 소스 코드에 하고 Markdown 파일에 해야 한다.
- 소스 코드 포멧의 통일을 위해서 편집기는 VSCode 만 사용한다. VSCode 를 사용해서, 각종 설정 까지 공유를 한다. 
- 모델하우스 코드 컨벤션을 통해서 통일성있는 코드를 작성해 나간다.

### Git

팀 작업을 위한 Git 명령어 사용법을 꼭 익혀야 한다.

예를 들면 fork 후 pr 을 하고, origin 에서 업데이트 된 내용을 local 로 받아오는 등의 작업이 필요하므로 이에 대한 이해를 충분히 해야 한다.


### 문서화

패키지로 만들어 공개하고 많은 개발자들이 이용하기를 바란다면 문서화를 잘 해 놓는 것이 가장 중요하겠다. 같은 맛이면 보기 좋은 떡이 점수가 더 높은 법이다.

그래서 가장 먼저 해야 할 것이 문서화를 어떻게 하는 것이다.

소스 코드 내에 문서화를 하는 방법과 Markdown 에 문서화를 하는 두가지 방법을 배워야 한다.


### 소스 코드 업데이트 방법: fork 와 pr

협업을 하는 가장 일반적인 방법 중 하나가 `fork 후 pr` 이라고 하겠다. 아래와 같이 하면 된다.

- 프로젝트 홈페이지: https://github.com/thruthesky/model_house 로 접한다.
- fork 한다.
- fork 한 것을 clone 한다.
- 자신 만의 branch 를 만든다.
- branch 에서 작업하고 push 한다.
- pr 한다.
- pr 이 완료되기 까지 기다린다 또는 핵심 개발자에게 요청한다.

그리고 업데이트가 있을 때마다 origin 에서 다운받는다.



### 코드 리뷰

코드 리뷰의 목적은 `pr` 을 accept 하기 전에 `하우스 개발 가이드`에 맞게 작성되었는지 확인을 받는 것이다.



### 핵심 개발자

- 핵심 개발자는 git repo 의 collaborator 로 등록되는 개발자를 말하며, 참여도가 높고, `하우스`를 잘 이해하는 개발자이면 된다.
- 핵심 개발자는 주로 핵심 기능을 개발하고, 코드 리뷰를 하며, PR 을 머지하는 역할을 한다.
- 핵심 개발자 신청은 thruthesky@gmail.com 으로 연락을 하면 된다.



## 하우스 스타일가이드

참고: [하우스 스타일가이드](./style_guide.md)

