defmodule DaySixSolution do
  def solve(input, freqency_comparator, freq_guard) do
    lines = String.split(input, "\n")
    [first_line | _] = lines

    list_of_lists = Enum.reduce(1..String.length(first_line), [], fn(_, acc) ->
      [[] | acc]
    end)

    lines
    |> Enum.map(fn(line) ->
      String.split(line, "", trim: true)
      |> Enum.with_index()
    end)
    |> Enum.reduce(list_of_lists, fn(line, acc) ->
      Enum.reduce(line, acc, fn({letter, position}, inner_acc) ->
        new_list = [letter | Enum.at(inner_acc, position)]
        List.replace_at(inner_acc, position, new_list)
      end)
    end)
    |> Enum.map(fn(column_list) ->
      Enum.reduce(column_list, %{}, &update_count/2)
    end)
    |> Enum.map(fn(frequency_map) ->
      {most_frequent_letter, _} = Enum.reduce(frequency_map, freq_guard, fn({new_key, new_freq}, {old_key, old_freq}) ->
        case freqency_comparator.(new_freq, old_freq) do
          true ->
            {new_key, new_freq}
          false ->
            {old_key, old_freq}
        end
      end)

      Atom.to_string(most_frequent_letter)
    end)
    |> Enum.join("")
  end

  def update_count(letter, acc) do
    Map.update(acc, String.to_atom(letter), 1, &(&1 + 1))
  end
end

most_frequent_comparator = fn(new_freq, old_freq) -> new_freq > old_freq end
most_frequent_guard = {nil, -1}

least_frequent_comparator = fn(new_freq, old_freq) -> new_freq < old_freq end
least_frequent_guard = {nil, 10_000}

test_input = "eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar"

IO.inspect(DaySixSolution.solve(test_input, most_frequent_comparator, most_frequent_guard))
IO.inspect(DaySixSolution.solve(test_input, least_frequent_comparator, least_frequent_guard))

input = "bgpmxqws
mxvdaluh
wpgcrcix
djugxgak
urjgbqde
vcsylkay
ruyowwjt
eepdbfaa
kpzjujdv
ilsbjxbf
xljdcdpc
vnmtqzbu
dsiruyjs
oemrvmqj
bunqbyjw
wixyxnwq
tfmpgyen
rxjphoyf
keohkpwv
gbpfqodg
palgwnye
zzriwene
wmczggbk
xikxduml
estibkpk
ivcghhot
uvczidij
qmdmpfxn
xjgypmry
xwzgzxeu
ejvoqgyr
qzbnawul
mhtvpsma
vzddmtyx
ckhdphcd
rrxiqrqd
tdnauotp
zsoqslob
oxbleyra
dfspawmw
amewbjnz
dhryqzsg
gevzondd
gjtlhacs
ywoghawg
xgiglflw
jlfewwky
xvhjgvhk
baocvjcl
wnweoaib
uepsdnur
vmynttbb
aoqezdgl
oahtcpli
hixokbhp
rsdwsjnv
nqckpjlt
jksheyvr
asabcisr
jirzozrt
jypcypek
hbeimsej
vzwnchwy
ozjqqyaz
hbxcqvne
yfmthknj
yxicfnav
fhfwaetl
lyhvemqr
kyyzkgfb
unigfcbx
jyszsjto
qoomixgp
vwqlvanp
wteqnjhj
dtcfvira
wztxowzh
rjuayajd
mcvaqelp
wazbrrej
qwuiszub
fohaxlyl
vizomswk
pkjhxghs
xhygtcbp
grzjvlas
tgssuvej
jypumznm
ymiymxbk
fdnhxmpc
nqwlpigo
ecpyhmgw
hbxpvgoh
pkflsrjo
zrjugqge
jwvlowtd
mkslbbql
hsektxsi
psanaqop
ylorypou
tkfircdx
ftkfzmno
rdasheam
eulndcvo
gpetuqvl
felsxwks
xckkdvyc
nlbymfrt
gcqxmyse
gbbnguow
cdaduwiv
sqikwrbi
ppwteldh
tyurlqsr
oogkdood
slxekxkj
tunmorwo
mphktfgp
ylkifdek
byopdakn
zgpqnghe
lltqwxuf
palhjqcb
xxrbywel
xolycxlx
bkiimxvx
htztessk
aamwgfrm
extuovqh
bpkmstaf
hazuzhkf
cjiqycqs
sxafxxpp
mtfowzth
poosymcj
vbykdleq
bxhhfyak
kbyminxs
gviprbxv
bqxhjffd
wmuwlzoy
iwazluuu
uhwxfelq
gfvqwfgj
uqvyjkgr
eanwjhhl
izpooten
gkqhaiel
jforeagg
hrqjylmb
kcvfbohb
jkoskwff
ymuqatcy
naeceeru
alghunmu
ygsgeyxy
fhsxqtsx
iikldgzj
zwsdownm
svbdvddw
ujwdwmju
puszwwxg
pwzuivlo
noqjcwqu
lsnvidsn
rhuvjosk
rxktxanu
iftbsfjc
kgrxrkwl
rfzknqde
afqcjguq
sghybsrn
qtipzcwy
yyqhuufw
zaeukrhr
rqtlcflu
ridxvnur
wcxzmvka
pqxcddgq
eetnhsux
kblokhxx
bmctwlgo
cpojyilz
yhnmkhjp
btudgpci
mzvjtlhh
xabfbuvt
jgoltfpy
gsjdsaco
bmxhpnri
ncdkduzl
jhzyshfz
qhruewva
cgkafvvm
ntjbaria
rpfxuhht
wnqbudow
bcezvcpt
nqrhgrkn
tceyjrqf
pyszfamz
nctlttmt
bvhanhoc
ilffiatn
fwmskxwg
vezsripn
hbjxpdyd
tjnpgdib
tiuniqdj
mrzlrnmn
ngqrtjxr
eoyorrfy
rtkidptz
zwglnkeu
anjcxsgc
dbuotxcq
sqpsxbmt
czyxgtcv
ojhmhssl
lfbhgnox
pecipazx
nvcfxguk
gdniujcm
tcdfhgez
zxzybtvb
oddtlvmw
vxdcfivs
ldgbhriu
lcuccuup
dwzyuvkh
pdoomnps
jfaqworq
zfeecwuy
zxytmbzh
iuzcfqac
kxvxqpam
gyfryaqu
dusowjue
uwrofbxz
jwhbtsgg
tjpubrqi
vncupbao
lbusnztb
kbpkhcau
prrcxgti
aflcpnsq
xtspjvwl
fqjgujib
tnlahhpp
boovsuro
eytzygmd
vdyysubn
syxcupva
ulgjkkdy
pzhevrme
vynmztwh
wrwebmrb
pdfniopo
nnusdprq
qzrnxboz
fhvnyafq
isbzhjnq
nxfvcxvy
iuzgpevj
apjpvsdk
unltokdk
neccyyrf
gkkafbth
udnurvso
gzosdaws
snetsjdd
zcsgluqb
fdsvyiho
kjvmexiu
ugfpphts
dbkvkdok
drpkejfw
lwyshtxq
qilaojzn
qilwixhi
hbuzdkgg
amdettxe
rilvspmg
cyvfwmwg
kqbmwvvi
nuxdfinf
ozfvzigf
vhjvfosm
vfmgntex
cswjzkft
kvqqlvbh
ppwpiqcb
wewsncdj
ndkjslvd
livwaogi
slupeobk
chvlbixa
oprvhtpn
wrgwrzic
meyhlwzr
wcwplger
cfdwqikc
vokgnzjv
sxmxzlwh
rttwwsrg
apqmweoc
xcrgliqw
egjenpzi
uuaoghhw
ubaubqir
slxfrqfz
uooravpz
jukdeivx
qvelgzzi
zbcnzjsj
noivjeht
tomkyktn
owixssbg
qrjikjok
opieopkj
hzrratbf
tawhmgiz
zojlupqh
iuxrcduy
gxdvgzke
tcsqiada
oqanfwxs
hoeavozw
kteefzjp
xjepfoho
acaimhfz
ifeqkbqc
szwlvqwc
jrtfkzxv
aqgmlcyg
stsejxzs
mukbwojc
yorhqkqz
qgkehpbu
qrpealli
mcwerdgx
vqxkeyqe
pmstbkfy
uriiqytq
puyrfebm
cljqpflg
yhjxqfee
wvyitlyj
stvxunze
surpasjh
laqbwefs
tmhzxhcp
xnrmdgci
cvoziimt
dbeqiwio
bncszppp
wajpsycd
ncmrinrp
zsctcqzy
vkfwzoda
zeturmnd
dydeylro
gggkrwzw
oobmkfhz
vimgaxkq
cuftcyxg
jzczmzab
jqvvaljj
fvlbbduo
tvoipipg
ihdqovcz
fhylllit
wngiyeld
panifluc
nariaulb
uiqpccns
vdeevhcb
fjddbcfa
nymgtdmf
qvkrocra
lelplbmu
qwajtxne
cjgljjwm
kdyecbii
rmhccint
meclgocv
ahvvcbck
uktuwuag
dcnpzwjn
igfbtmnr
wdioghpd
keuuecam
clxwiylf
oqsbygex
dbxhlukg
rkxjjlvn
votomymd
hqyfigpr
qnuvattu
flrxtbsl
zinwdott
wxpzgsxk
glvwrzqv
asruvcjq
aanwzupj
krbxlowc
nfbrzogr
ivvbjgyt
mxbuttye
rhzksroq
skipgtsv
wrfnmsgm
ckdgipqw
uxbylsdi
bazhagcz
melrnxrj
qqqoyhqf
hrfjpsrx
hafnvrdg
wzasinyu
frbkqlzq
pkpasbfh
uaadlrys
tjxovpar
lvqxahjd
ereefqow
tmwalbhi
eflnfinc
hwmxucjt
iedrvuyy
mnmxdbhv
qghmvftt
boqbamap
rjfncukp
jsyshihy
kwfcnspx
lsvaiysm
xlypkceq
uvpxfarx
onktnulb
crycggor
hzntxzxs
jodwwaaj
asmnoijg
lkgabxtn
yinohytm
cymfafvu
pfwnxkga
fcaepans
drpzqntz
dmtlraxa
xpuaeobo
npwbdnyw
prgddqif
cfjaozss
ynarmrcs
ydkoyipv
rxbjmxfy
ytbnudvq
rtcauesa
gwvfttly
xxocfbov
oepykzhu
siaojkqc
xumasfkb
mpaimhwd
lutlhkrm
hmlmhezr
hkffbvol
jhnyuwbk
xfunkzni
gvhtrpfw
zqcfnvmn
cwsftepw
vfgrhquw
hspqqeka
khebmbyz
hjinidaa
ljgfvzhi
bgyfruun
qhruutty
onanrpll
qsfqisbh
oyhlplyf
mpnbcbjv
dfjjijeg
bgbrnyhl
ouybnypn
ciemtumh
ostosnmx
zxmuoqdf
touhjqxz
uqzlprdk
twplkydd
ckfkowhr
esjrccyf
ebidrjtd
yakqyhfv
kgohdxvc
fmlurdki
lpzvjdzi
qgouskfp
jyhqxfft
lmngjjil
diswenna
awidoqvi
dpgeemdk
cyckbeyc
ysxatowo
mmjigkqq
lcaaoore
bbleeyyn
seuzxpgr
qthrjfya
fnkeqtep
lkykhmgv
mgosqkkf
otrjzklc
jqmmyvsd
ildfyzld
eubkvrel
gispnfiv
hlhoeiif
shruvvsc
woitvqxc
bmbitfft
vzrdnbrq
enxhxgmq
mmnodgks
iocqmalp
yklqxeii
piakutiq
aszalaqn
lbgkpcnt
yrwdtvuv
rtlvmzej
fwtjkmxe
xiivpktx
dqsssnus
kcbbesoj
lsqczazm
fuzgkvig
izqabubp
ennmupvh
sjgycnfm
nemdzypm
kqqritkb
jpfvpfex
axqruijm
fidctvkt
nzzbxsfp
uugacsof
fdgdphbf
wdvcnnts
eqtzaieh
azkgkmmv
zawfrbzx
xhcwzulk
tjbjvefm
wfxxndko
ykqydswm
xexihoxm
iaqsolsy
kjnherjw
dtagrwkw
eqxoamoo
ztuyerzl
ypdwcvjn
iydqnaih
ekmjoplw
dbctlhav
znowycbz
yvigzdzr
zfdfimzy
chtxbdbz
syqpswah
xwbtnnae
sgiumfoa
irpzjuce
rejvrhgk
jgwuwcyd
hpejgjsm
kvtvleno
mdcsgemu
tombqbcl
qlhwwdbn
elltzqpr
tmcrjpzw
rdexwdvq
lpvdqkpb
sblwoucv
enhzblxm
bjuvkbvz
euhyzmdx
mkgflghc
aabcdkwr
mdiksuzc
mxgjblyu
quhhkxgd
fgwqnkba
dvlmyqxh
bdgmqcue
dvpsxrxu
gnddfjtv
vyebxsui
htqhzeub
gmwwjlwx
ovcnnosg
ubzzoplu
zyutatwp
fvyeceuo
kjtslrdl
gimazmqa
azwjgikh
bjmsezgf
qlwydcqb
slkjjyjt
iermgjvf
itktqmjg
azaumrnj
zpnkffmz
otpjumye
omaijeay
yddmqxle"

IO.inspect(DaySixSolution.solve(input, most_frequent_comparator, most_frequent_guard))
IO.inspect(DaySixSolution.solve(input, least_frequent_comparator, least_frequent_guard))