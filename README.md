<a id="readme-top"></a>

<!-- Icon -->
<p align="center">
    <img src="./media/icon_hd.png" alt="icon_title" width= 200></img>
</p>

<!-- Title & Description -->
<h1 align="center"> [Cipher Dove] </h1>
<p align="center">An open-source, offline, ad-free, basic encryption and decryption tool. </p>

<!-- Badges -->
<div align="center">
    <img src="https://img.shields.io/github/license/Daniel-C-J/cipher_dove" alt="license"></img>
    <img src="https://img.shields.io/github/v/release/Daniel-C-J/cipher_dove" alt="release"></img>
    <img src="https://github.com/Daniel-C-J/cipher_dove/blob/master/coverage_badge.svg?sanitize=true" alt="coverage"></img>
</div>


<br/>
est. read time: <b>6 minutes</b>
<br/>

## Quick Start
Currently, this app only supports for Android. I am unable to test the app for iOS platform, since I don't have any apple device.
[Download latest version here.](https://github.com/Daniel-C-J/cipher_dove/releases/latest)



## About Cipher Dove 
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)"></img>

This project, **Cipher Dove**, is an application intended for the purpose of showcasing my flutter skills... and also for fun.

1) This app is just your another simple basic encryption-decryption application with known and common algorithms, but optimized with certain packages that is fast, and have low memory consumptions. 
2) This app is quite small, around 30MB.
3) This app android `min-sdk` is 21. 


### Architecture

Yeah, after a brief inner-debating, feature-first might be good enough for this project. So this is what it looks like:
```
├─common_widgets
├─constants
├─core
│  ├─app
│  ├─local_db
│  ├─network
│  ├─theme
├─exceptions
├─features
├─routing
└─util
```


#### Example Feature Structure
```
features/
 ├─cipher
 │  │  ├─data
 │  │  ├─domain
 │  │  └─presentation
 ```

The principles here are: 

- **Feature-driven**: Each feature is independent and reusable
- **Domain isolation**: utilities → features → widgets → app
- **Consistency**: Between business logic, UI, and data layers


### Features

Currently this app supports:
- Aes Encryption/Decryption
- Chacha20 Encryption/Decryption
- Md5 Hash
- Sha-1 Hash
- Sha-2 Hash
- Sha-3 Hash
- Blake2 Hash

<img src="./media/screenshot (1).png" alt="screenshot" width=350  style="padding: 5px;" ></img>
<img src="./media/screenshot (2).png" alt="screenshot" width=350  style="padding: 5px;"></img>
<img src="./media/screenshot (3).png" alt="screenshot" width=350  style="padding: 5px;"></img>
<img src="./media/screenshot (4).png" alt="screenshot" width=350  style="padding: 5px;"></img>
  
Upcoming cipher algorithms:
- RSA
- DSA
- ECC
- Argon2
- etc...

<br>

Overview of this project dependencies:
- Riverpod (State Management & Dependency Injection)
- Dio (Network requests)
- Logger (Logging)
- Localizations
- SharedPreferences & Hive CE
- GoRouter (Routing)
- And many more...!

[See Changelog](./CHANGELOG.md)

## Community and support
No, currently I'm not accepting new features, but you can still submit a bug report.

Yes, coffee is okay for me.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P4L666F)


## Install
Please head to the [release](https://github.com/Daniel-C-J/cipher_dove/releases) section to find the latest version of the app.


## Build
Make sure you have Flutter framework v3.27.4+ installed.

1. Clone this repository 
```sh
git clone https://github.com/Daniel-C-J/cipher_dove.git
```

2. Open your terminal and `cd` to the root path of the repository, for example:
```sh
cd cipher_dove
```

3. Type `flutter build --help` then head down to the `Available subcommands:` section, you'll be able to found the platform specific options to build the app. 
```sh
flutter build --help 
flutter build apk --release # If you choose to build android app.
```

4. The output path is usually in `./build`, for android specifically it is in `./build/app/outputs/flutter-apk/` alongside with the `sha-1` hash.
```sh
start . # To quickly opens file explorer to see for yourself the output.
```

5. And you're done! Congrats 🎉!
   

## License
Distributed under the [MIT License](./LICENSE).


## Contact
Daniel CJ - dcj.dandy800@passinbox.com

Project Link: [https://github.com/Daniel-C-J/cipher_dove](https://github.com/Daniel-C-J/cipher_dove)

<p align="right">(<a href="#readme-top">Back to top</a>)</p>


