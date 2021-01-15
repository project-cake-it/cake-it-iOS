# Cake'it! iOS

<img src="https://img.shields.io/badge/Swift-5.0-orange" align="left">

<br>

## 🤖 GroundRule

## 🚀 일감

이슈와 깃헙 프로젝트를 활용하여 현재 어떤 일을 하고 있는지 쉽게 공유할 수 있습니다.

- 작업을 이슈로 등록하여 관리한다.
- 작업 중인 이슈는 프로젝트에서 작업 중 보드로 이동시킨다.



## 🚌 브랜치

브랜치를 세분화하여, 배포와 유지보수를 더 효율적으로 관리할 수 있습니다.

- `main` : `develop` 브랜치에서 실제 배포 시에 push 하도록 한다. 배포 시 버전을 tag하여 브랜치를 관리한다.
- `develop` : 기본적으로 PR을 보내는 개발 메인 브랜치입니다. 
- `feat`, `fix`, `hotfix`, `doc`, `refactor`, `chore` : 개인 작업 시에 현재 작업하는 일감에 따라서 브랜치 앞에 명시 후 뒤에 `/`를 붙여 관리합니다.



## 📌 커밋 메세지

- 커밋 메세지 header에는 커밋의 타입과 함께 타이틀을 기재한다.
- 커밋 메세지 body에는 구체적인 변경 사항을 기재합니다.
- 커밋 메세지 footer에 이슈 번호를 기재한다.

```
// 커밋 메세지 예시
주유소 상세페이지 UI 고도화 작업

- 이미지 리소스 UIKit으로 변경
- 이미지 리소스 제거
- XIB와 스택뷰를 활용하여 주유 가격 정보 화면 구현
- GasType enum 타입으로 종류별 데이터 분류

#12
```



## ✅ PR/코드리뷰

PR을 모든 팀원들이 확인하고 컨벤션을 서로 확인하여 전체 코드 진행상황을 따라갈 수 있으며 유지/보수에 용이한 깔끔한 코드를 작성할 수 있습니다.

- `develop` 브랜치로 **PR**을 보낼 때 팀원들의 모든 리뷰를 받도록 한다.
- [PR+코드리뷰 레퍼런스: 뱅크샐러드 코드리뷰 문화](https://blog.banksalad.com/tech/banksalad-code-review-culture/#github과-비동기-커뮤니케이션)



## 🗂 디렉토리/파일

디렉토리의 기준을 만들어 파일을 빠르게 찾고 접근할 수 있으며, 파일을 나누어서 코드를 변경했을 때 영향을 최소화할 수 있습니다.

- 기능단위로 그룹을 나눈다.
- 해당 기능 그룹 안에서 다음과 같이 그룹을 한 번 더 세분화한다.
  - Views/Models/Controllers 로 나누어 파일을 구분한다.
- 구조체/클래스 하나당 하나의 파일을 가지도록 한다.



## 📑 Swift Style Guide

- [Swift Style Guide](https://github.com/project-cake-it/cake-it-iOS/blob/develop/documents/swift-style-guide.md)