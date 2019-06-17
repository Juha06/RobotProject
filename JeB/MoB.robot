*** Settings ***
Suite Setup
Suite Teardown    Close Browser
Resource          tervehdys_resurssi.txt
Library           SeleniumLibrary

Library    AppiumLibrary
*** Variables ***
${url}            https://www.discshop.fi/login.php
@{CREDENTIALS}    boju60    Hyviini60
&{login}          Username=boju60    Password=Hyviini60
${status}         PASS

${arvo}    42
@{fibo}    1    1    2    3    5    8    13
${nolla}    0
${yksi}    1
${laskuri}    1
*** Test Cases ***
Eka
    Sano hei

Toka
    [Tags]    Toka
    [Setup]    Log To Console    Test Case Started
    SeleniumLibrary.Open Browser    ${url}    browser=chrome
    Login
    SeleniumLibrary.Close Browser
    [Teardown]    Log To Console    Test Case Complete

Kolmas
    [Tags]    Kolmas
    Login

Neljas
    [Tags]    Smoke
    Log To Console    Test four started
    Open Browser    http://google.com    chrome
    Close Browser
    Log To Console    Test four completed
    Set Tags    SmokeTest
    Remove Tags    SmokeTest

Viides
    [Tags]    Sanity
    Log To Console    Test Viides started
    Log To Console    Test Viides completed

Jos
    [Tags]    Jos
    Run Keyword If    '${status}'=='PASS'    AnotherAction
TokaJos
    :FOR    ${var}    in    @{fibo}
    \    Run Keyword If    "${var}"<="2"    Slogan1
    \    Run Keyword If    "${var}">"2"    Slogan2
    
RangeSilmukka
    :FOR    ${var}    in range    6
    \    Log    Born to lose, live to win
Silmukka
    :FOR    ${var}    in    @{fibo}
    \    Log    ${var}
RepeatSilmukka
    Repeat Keyword    ${arvo}    Slogan1
Laskuri
    ${laskuri}=    Evaluate    ${nolla}+${yksi}
    :FOR    ${var}    in range    99
    \    ${laskuri}=    Evaluate    ${laskuri}+${yksi}
    Log    ${laskuri}
*** Keywords ***
Login
    Input Text    id=username    @{CREDENTIALS}[0]
    Input Password    id=password    &{login}[Password]
    Click Button    id=btn_login

GoToPage
    Open Browser    ${url}    chrome

AnotherAction
    Log    Another action
Slogan1
    Log    Born to lose, live to win
Slogan2
    Log    I'm so bad, baby, I don't care
    A