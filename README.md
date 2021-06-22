# About Extended Plane-Wave Expansion Method(EPWE)
About its description which is written in English, you can check [this article](https://link.aps.org/doi/10.1103/PhysRevB.72.195118).

In this repository, it shows its codes which are written by Matlab. 

And its concept has been explained in the first part of file [oral.ppt](oral.ppt). Sorry, it was written in Traditional Chinese and some words might be unreadable since I used something like [MathType](https://docs.wiris.com/en/mathtype/start) to type in the Math equations and might some characters belong to [Mathmatica](https://www.wolfram.com/mathematica/).

Before you test this code, keep one thought in your mind: this is not a commercial App that is focused on what it can provide for the users through its UI part. 
This code is used to realize the theories mentioned in the papers which are used by [oral](oral.ppt).
The true value is inside those theories and this code is just used to help you have a deeper understanding of these theories.

Therefore, I have to give a special thank to Prof. Gu since he introduce me these theories and even provide me a matlab code base to test on.
From the part II and part III of that [oral](oral.ppt) are based on his idea, guiding, and teaching. Thanks to him.

So, I should say: if without Prof. Gu's help and the people who share their thoughts, this code wouldn't be shown here. Thanks to all of them.
# How to Use
Basically, this code's main part is [ymode.m](ymode.m) which is based on the concept of EPWE.

And, [abcd.m](abcd.m) is for 2D transmission and its space configuration is that `x<0` region is for the air and `x>0` is for the 2D photonic crystal, respectively.

## Start point `start.m`
You can start to test it through [start.m](start.m).

Oh, you might need to copy `creatframe` to this folder before you run it.

You can change its first parameter from `o2ky` to be `eband`, `o2kr`, `o2kyall`, `interface2omega` to get results from different cases.

The parameters that you can input are:   (它的欄位分別為)

* max|K|: input value m (輸入數值m), means (表示) Gx=-m -> m, Gy= -m -> m

* pattern: input the name which is defined in `epslon1.m`. (輸入名稱，其名稱定義放在epslon1.m裡頭)

* \omega: The frequency. For `o2kr`, `o2ky` and `o2kyall` are just a number; however, it should be a range for `interface2omega` case. (所要畫的頻率，o2kr, o2ky, o2kyall 都是輸入一個值，而interface2omega則要輸入一個範圍。)

* ky: The fixed `ky` for your calculation. ^_^ (即EPWE method 中要被固定的部份。)

* folder: Output folder for your calculation. (要將計算結果存在哪個目錄。)

If you want to know how functions related to each other, please execute `matlab/Editor/Tools/Show Dependency Report` to see its result.

(想知道function 間的關連，請執行`matlab/Editor/Tools/Show Dependency Report`即可。)

By the way, if you want to draw the behavior around the interface, please run `incident.m`.
(另外，如果要畫出介面上的行為，請執行incident，)

You can run its Example shown in its comment. However, take care of some situations: 
(裏頭有範例，不過，請小心以下幾點：)

1. Don't let `ky>\omega` which means that your incident light itself is an evanescent wave. I still not take care of this kind of situation.
(避免ky>\omega，因為，這表示入射光根本就是evanescent wave，
這會使得在確定conservation時出現問題。)

2. The better way is to plot `eband` at first so that you can know the frequency range for your wave can propagate in your photonic crystal. Then draw `o2ky` for the frequency that you want to check to decide which ~ky~ you are interested in. Then, you can get the result you want from `incident.m` by providing it this ~ky~. 
(請先畫 eband，確定要看的頻率範圍，再用o2ky看該頻率，再決定要看哪個ky，
最後，再將該ky輸入給incident計算。)


If you want to get some visual results like how your wave function looks like, or quiver, you can execute the codes inside the subfolder ~wavefunction~.
(如果要看波函數的型態，或者是quiver，可以到subdirectory:: wavefunction 去看。
請執行vvector來看。
詳細的部份，請自行修改。)

Have fun!

# Acknowledgement
首先，這研究的成立得感謝楊宗哲老師與顧本源老師，尤其其概念源自顧老師的介面匹配的計算，有那些概念後，才能生出這個研究。

然後，得感謝許多樂於分享的人的貢獻，我由顧老師的Matlab 程式出發，透過網路上許多別人分享的程式而學到更多的概念，再加上網路上許多人無私地將他們所知的分享給大家，才能生出這個研究。

是的，有個研究說一個城市的創意數量約與該城市人口的1.29次方呈正比，而越開放的社會這指數則越高。我的理解是，創意來自人與人之間的交流與分享，即便是透過建築物、畫作等靜態的也是，到不了指數2是因為無法達到任何兩人都能交流，而且，私心會使人不樂意分享，造成僅僅是表面的交流。

謝謝日本這次無私地給台灣疫苗，而這又可回推到台灣在311時也曾如此幫助過日本。

人啊，幫助自己的未來，為自己的未來打算、買保險等沒甚麼問題；但上面的例證已經很清楚地可以看見，樂意分享與幫助別人，其實就是在幫助未來的自己或後代。創意的指數不是1是比1更大的。
同樣地，幫助人所得的會比自私所得的更多，也許眼下是吃虧，但，那這吃虧是定義於我們自身的感覺，是來自於短淺的時間觀來的。

照聖經講，我們不過都僅是水桶裡的一滴，在時間的洪流裡，恐怕連一滴都搆不上，希望人類這族還能存在嗎？那就樂於分享吧，是分享與愛使人類能越來越好。