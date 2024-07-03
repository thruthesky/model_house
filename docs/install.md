# 설치


하우스는 파이어베이스를 기본적으로 사용한다. 그래서 아래와 같이 파이어베이스를 먼저 설치해야한다.


## 파이어베이스 설치

- Authentication 에서 email 과 phone sign-in 두 가지를 기본적으로 적용한다.

- Firestore 를 활성화 하고, Firestore security rules 를 설정한다. 만약, Security 설정이 익숙하지 않은 상태에서, 테스트를 위한 프로젝트라면, Firestore security rules 를 전체 허용으로 해 주어도 된다. 그러나 Security rules 는 꼭 필요한 것이다.

- Realtime Database 를 활성화 하고, Realtime Database security rules 를 설정한다.

- Storage 를 활성화 하고, Storage rules 를 설정한다.

- 백엔드를 함수를 사용하기 위해서 Cloud functions 를 배포한다.

- Message 서비스를 활성화 한다.


## 앱 설치와 dependencies 설치

늘 하던대로 flutter create 하고 flutterfire configure 를 한다. 참고로, Firebase SDK 는 `하우스`에 설치된 것과 동일한 버전으로 설치해야 하는데, [모델하우스 pubspec.yaml](https://github.com/thruthesky/model_house/blob/main/pubspec.yaml)파일을 참고한다.


설치 예제

```sh
flutterfire install 2.2.0
```

위와 같이 명령하여 `Core, Authentication, Firestore, Functions, Realtime Database, Messaging, Storage` 를 선택한다.

그리고 아래와 같이 파이어베이스에 연결한다.

```sh
flutterfire config -a com.modelhouse.example -i com.modelhouse.example -p withcenter-test-5 -y
```


그리고 아래와 같이 코딩하면 된다.



## 클라우드 함수 설치

## 파이어베이스 Security rules 설치




## iOS 추가 설치

언어, 카메라 entitlement


## 간단한 예제 앱



## FireFlutter 패키지를 개발자 모드로 설치하기


