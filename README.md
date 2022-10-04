# Database of modular forms of Noncongruence Subgroups of PSL(2,&#8484;)
## Development status
### Genus zero

| Index  | Amount of computed passports / Total amount of passports |
| ------------- | ------------- |
| 7 | 3/3 |
| 8 | 1/1 |
| 9 | 9/9 |
| 10 | 9/9 |
| 11 | 6/6 |
| 12 | 23/27 |
| 13 | 22/23 |
| 14 | 21/29 |
| 15 | 54/62 |
| 16 | 36/65 |
| 17 | 16/35 |

The database currently contains 200 representatives of genus zero noncongruence subgroups. For each of these subgroups we have rigorously computed q-expansions of the Hauptmodul
and all modular forms and cuspforms up to and including weight 6. We also include numerical expressions to construct the spaces of Eisenstein series to around 1500 digits precision.

### Genus one

| Index  | Amount of computed passports / Total amount of passports |
| ------------- | ------------- |
| 9 | 1/1 |
| 10 | 1/1 |
| 11 | 0/0 |
| 12 | 2/3 |
| 13 | 1/1 |
| 14 | 1/2 |
| 15 | 6/9 |
| 16 | 7/9 |
| 17 | 1/2 |

The database currently contains 20 representatives of genus one noncongruence subgroups. For each of these subgroups we have computed q-expansions of the Hauptmodul
and all modular forms and cuspforms up to and including weight 6. We also include numerical expressions to construct the spaces of Eisenstein series to around 1500 digits precision.

## Requirements
The database can be loaded by running [Sage](https://www.sagemath.org/) scripts that were generated for the syntax of Sage version 9.2 (and hopefully work for the versions that are yet to be released as well). Additionally, the data for each entry is stored as strings in JSON-files.

## Database structure
The folders of this repository represent the indices of the subgroups and the subfolders correspond to the genera. Each database entry is labeled by the signature of the
corresponding subgroup which is of the form (h, g, n<sub>c</sub>, e<sub>2</sub>, e<sub>3</sub>) for which the variables are given by:
- h: index
- g: genus
- n<sub>c</sub>: amount of cusps
- e<sub>2</sub>: amount of elliptic points of order two
- e<sub>3</sub>: amount of elliptic points of order three

Each database entry contains the following information (for more background on the notation, please checkout [arXiv:2207.13365](https://arxiv.org/abs/2207.13365) and have a look at the examples below):
```
├── G: Instance of subgroup representative as a Sage subgroup
├── monodromy_group: Description of the monodromy group of G
├── K: Basefield of curve with specified embedding
├── v: Generator of v as an element of QQbar
├── u: u as an element of QQbar
├── u_str: Expression of u in terms of v as a string
├── curve: Expression of the curve
├── embeddings: Embeddings of the passport
└── q_expansions
    └── weight: weight of the considered space of modular forms
        ├── hauptmodul_raw: q-expansion of the hauptmodul with coefficients defined over number field L
        ├── hauptmodul_pretty: q-expansion of the hauptmodul with coefficients factored conveniently in K and u
        ├── modforms_raw: list of q-expansions of modular forms with coefficients defined over number field L
        ├── modforms_pretty: list of q-expansions of modular forms with coefficients defined over a number field with coefficients factored conveniently in K and u
        ├── cuspforms_raw: list of q-expansions of cusp forms with coefficients defined over number field L
        ├── cuspforms_pretty: list of q-expansions of cusp forms with coefficients defined over a number field with coefficients factored conveniently in K and u
        ├── eisenstein_basis_factors: list of floating point expressions that create the space of Eisenstein series in reduced row echelon form
        └── eisenstein_canonical_normalizations: list of floating point expressions that create the space of Eisenstein series in a canonical normalization
```
## Reliability of the results
For genus zero, all coefficients have been computed using rigorous arithmetic over number fields or rigorous interval arithmetic. The only exception are the Eisenstein series whose precision we can only estimate heuristically.
For higher genera, the coefficients are non-rigorous (but supported by highly convincing numerical evidence) because they have been guessed using the LLL algorithm.
As an additional verification, we have also compared the numerical values of the rigorous expressions and the Eisenstein series to the results of an independent numerical method to verify that the results match to at least 10 digits precision.

## How to work with the database
(Maybe put this tutorial into a Jupyter script.)  
Start a Sage session and load the corresponding database entry. In this example we consider the passport `7_0_2_1_1_0_a`:
```python
sage: load("7/0/7_0_2_1_1_0_a.sage")
```
This runs a script which constructs all the data corresponding to this entry and stores the result in a dictionary called `res`.
### Database elements
Let us take a closer look at the values that `res` contains:
#### G
This database entry corresponds to the subgroup `G`:
```python
sage: G = res["G"]
sage: G
Arithmetic subgroup with permutations of right cosets
 S2=(1,3)(2,4)(5,7)
 S3=(1,2,3)(4,5,6)
 L=(2,3,4,6,7,5)
 R=(1,4,7,5,6,2)
```
The instance of `G` offers a rich functionality that is documented [here](https://doc.sagemath.org/html/en/reference/arithgroup/sage/modular/arithgroup/arithgroup_perm.html).
#### monodromy_group
The monodromy group of the passport is given by:
```python
sage: res["monodromy_group"]
'C7 : C6'
```
#### K
The base ring of the curve is given by `K`:
```python
sage: res["K"]
Number Field in v with defining polynomial T^2 - T + 1 with v = 0.50000000000000000? - 0.866025403784439?*I
```
#### q_expansions
To load cuspforms of weight 6 in reduced row echelon form we type:
```python
sage: cuspforms_pretty = res["q_expansions"][6]["cuspforms_pretty"]
sage: len(cuspforms_pretty)
2
sage: cuspforms_pretty[0].degree()
717
sage: cuspforms_pretty[0].O(5)
q_1 + ((-4143801286656*v + 2701501787700)*u^2)*q_1^3 + ((13258983380236369920*v - 7054265472408117248)*u^3)*q_1^4 + O(q_1^5)
```
Note that we use the notation q<sub>N</sub> = exp(2πi/N) where N denotes the width of the cusp at infinity. Note also that for this example, the width of the cusp at infinity is equal to one so we chose `u` to be a rational number. For general examples, `u` can be the N-th root of an expression in `Kv` (where N denotes the width of the cusp at infinity). This expression for `u` is stored in `u_str`.
```python
sage: res["u_str"]
'1/823543'
```
To perform arithmetic, we can also work with the q-expansions in a raw format in which they are defined over the number field L:
```python
sage: cuspforms_raw = res["q_expansions"][6]["cuspforms_raw"]
sage: cuspforms_raw[0].O(5)
q_1 + (-4143801286656/678223072849*w + 2701501787700/678223072849)*q_1^3 + (13258983380236369920/558545864083284007*w - 7054265472408117248/558545864083284007)*q_1^4 + O(q_1^5)
```
Similarly, we can also load the q-expansion of the Hauptmodul and modular forms.  
To construct the Eisenstein series of weight 4 we note that:
```python
sage: G.dimension_eis(4)
2
sage: G.dimension_modular_forms(4)
3
```
The space of Eisenstein series is therefore two-dimensional and can be constructed from the three-dimensional space of modular forms. To get the corresponding basis factors for the first and second Eisenstein series we type:
```python
sage: eis_fact_list = res["q_expansions"][4]["eisenstein_basis_factors"]
sage: eis_fact_list
{0: [1,
  0,
  1.296498184329761992778680862762344601091174810086816441440733136706857129617820883774933217528067571063688654434859394354476959697210749094797861641180716183776518201079383901182362536169277343861047499865028076393367224120473554902933534520830232168475436825114824346962729442315152609444487674086794730579392922437263725878894164293685585914638346790895461776301943616234706981721075766112844636939616097690162827420545532025446783359509432980048421183093660345105863585367854221230150082427153163157801516255926055199873096179777196759024114478260701445725107468360624694376685907598961701214311773162728348348880326816326731533048510340841017405112175566705701458824970543149200589522128855975100763273299536369768689530282900633520704741578817443500855661865808179046140723102364270704757067571994754159371736024455402959356783559806850934949989565907518927840987587219888887538884725003851037510836532479818736870869661563856160944630696828359330324241827494164735201024104748562841578590142387759946950869689233915443827830777008397962618062354262579740746456693184215921442954124741460163840964597758045528910401663418265576150488065448341807289975188794831591646946510081521187826351750972064411752099275945323781588016959039141316868082450419399856912082955555374182735269113916483014860403729293873313245799399677692025652959310663337405081762159151024172519731902782760307127293922723113305357788903769270351618291123121055823768210457905299621462572840844518893609500797495382630397552 - 3.037217317203652643070604337356361268827806826506465501639886689240046105997440483945570334267842089657875858718218122135073938547049092613957492210745626326042341779433432780779047025287364279352631352245343605356485065318748897804458619312906813721590599989639561232928006629319720178538089298347592149010778205930228469835726437436110014436299257227549811075303563231682109710126497465033522144056312269158944758401840279547498071475192882650505916629838013628584023838729900775943943577558649163375550292913718945904052002889359214848209279916750702422788308650572839158789264073680387922998675980976900000596642346945364279687664947785710194198022287623189045283925860081856847280917959417022698683679520359373529819504158283588867705259544700822510845100279417856052302861620062846971341199530162344216867466553551340065638413654569601012470779801656885782013897796739868631798641522991063784722176096306097942598470646583981674154240802762827106006799195634279930412780943050983284525622953880639526795379610744337190499501256260702292104318414046282572510163699756802078782659500628684819101443931884694877450174561015962434072139334681765023009872711138545371001479126666081121428561125296963388326487871314904651332526890230883329076279278207617658801893755736511551665264760953451973330164663419797058493593248366466834174071181702405936127447224120162679844388599466291757155675955678562365009923443552551332471701166287597915981796516730777457280858341629301285227973724604693407473292*I],
 1: [0,
  1,
  8.994597924231959325030088829738490230828786771624638264827330278597054761959925746317604444926966385120567963939854752523523012667928288545438342243161747015900931174162169233745073489432628011067245635417229049681694303232831360187904443606163207365964685679895354898554321960657020197460647968024638355289252529489844734475504607648776310058689006888371268909265408568265688720909495517641196480679418266259624321552414393616560638402668710695916464911737109748562058901727633940744874374656553528486842493682266974770000528765917595013504066189673913743976145385548497397106763808718337659578273700945155298548546331971598638618612297873579829094145365935138726243921562622736878330876991129766770413486361251931792630460290487914026997063576754927318746434742225799253974413653740148872063512218450021857669284433231435821002680068500804787771041710142052004467329218386583796301921313645817287343704847781334088596371376410150599329397372096548502790315659052107646936662399563547654826755874406717666887704709628192018984050705095798341822424740190572584413556430445065766993987691146910582650662647509341476962873326402423893432706299727298575802958436713354868368137722874660328384056867704283064951032919683561150910049929337336911179716323123252500596199654351852607571936378692014654104748317794608861194809169168009616559779336205569427478825991003537399281167783738405165386969608655320361227675879567628040201590453653662267400965789758727918243905946496481171276627080010435905706677 + 0.01265507215501521934612751807231817195344919511044360625683286120516685877498933534977320972611600870690781607799257550889614141061270455255815621754477344302517642408097263658657936260536401783063596396768893168898535443882812040751857758047044505717329416662349817180386669428883216741057537207644830062087824252470928529098219348931712506015124690511479087948043151346534212379219373943763967560023463445482893649334100116478124196447997034437710798595765839011910009932804125323309976490649437151406479288714049560793355001203899672853420533298646126009495128604405349649495526697366828301249448325407041666915267644560568449869860394910712580915842619842995435534969108367440353033715816423759457784866466816405637424793399284828694877191476958676046185458449757440021792859008359519571392166470900976757028111063979725027349339022737333755196158250690369075839124081974945263249433967912943243634240040127540809416029436076659030897600334484511294169499664847616637671992059604576368552342897450266469498074837810140496041458856775292621710132672519284405212568208232000866159441458595285341292268304951956198937572733756651014196724722784068759587446962974393904583949636110867133928567135540401411802703279714543604721886204262868053781783032586507357834122398223546479860526983730604988887568609758248774372330520152694514239196325709335806719769676716734449935161916444288232148198314866067652087468101480229721863208819286499131659081881971157273867024309012208868844989051918622253113872*I]}
```
To get a floating-point approximation of the first Eisenstein series we run:
```python
sage: CC = ComplexField(int(3.33*1500)) #Complex Field with about 1500 digits precision
sage: modforms = res["q_expansions"][4]["modforms_raw"]
sage: eisforms = [sum(modforms[i]*CC(e_j_basis_facts[i]) for i in range(len(modforms))) for e_j_basis_facts in eis_fact_list]
sage: eisforms[0].O(5)
1 + (1.29649818432976199277868086276234460109117481008681644144073313670685712961782088377493321752806757106368865443485939435447695969721074909479786164118071618377651820107938390118236253616927734386104749986502807639336722412047355490293353452083023216847543682511482434696272944231515260944448767408679473057939292243726372587889416429368558591463834679089546177630194361623470698172107576611284463693961609769016282742054553202544678335950943298004842118309366034510586358536785422123015008242715316315780151625592605519987309617977719675902411447826070144572510746836062469437668590759896170121431177316272834834888032681632673153304851034084101740511217556670570145882497054314920058952212885597510076327329953636976868953028290063352070474157881744350085566186580817904614072310236427070475706757199475415937173602445540295935678355980685093494998956590751892784098758721988888753888472500385103751083653247981873687086966156385616094463069682835933032424182749416473520102410474856284157859014238775994695086968923391544382783077700839796261806235426257974074645669318421592144295412474146016384096459775804552891040166341826557615048806544834180728997518879483159164694651008152118782635175097206441175209927594532378158801695903914131686808245041939985691208295555537418273526911391648301486040372929387331324579939967769202565295931066333740508176215915102417251973190278276030712729392272311330535778890376927035161829112312105582376821045790529962146257284084451889360950079749538263039755239272 - 3.03721731720365264307060433735636126882780682650646550163988668924004610599744048394557033426784208965787585871821812213507393854704909261395749221074562632604234177943343278077904702528736427935263135224534360535648506531874889780445861931290681372159059998963956123292800662931972017853808929834759214901077820593022846983572643743611001443629925722754981107530356323168210971012649746503352214405631226915894475840184027954749807147519288265050591662983801362858402383872990077594394357755864916337555029291371894590405200288935921484820927991675070242278830865057283915878926407368038792299867598097690000059664234694536427968766494778571019419802228762318904528392586008185684728091795941702269868367952035937352981950415828358886770525954470082251084510027941785605230286162006284697134119953016234421686746655355134006563841365456960101247077980165688578201389779673986863179864152299106378472217609630609794259847064658398167415424080276282710600679919563427993041278094305098328452562295388063952679537961074433719049950125626070229210431841404628257251016369975680207878265950062868481910144393188469487745017456101596243407213933468176502300987271113854537100147912666608112142856112529696338832648787131490465133252689023088332907627927820761765880189375573651155166526476095345197333016466341979705849359324836646683417407118170240593612744722412016267984438859946629175715567595567856236500992344355255133247170116628759791598179651673077745728085834162930128522797372460469340747329150687*I)*q_1^2 + (1.35429208493086052685346697129252192911295560505832694588890385369845935914759241252801663016847804998408806057447577853901309193407569245685575355495825621213439112417009239312956627837673804716545069132325267145922112597325524244659508061648510774526131845770515951488355606023452789476789654660616968623668030454241713427458247222864031051449999473286097834871505190310175078552013062487413155339182408635063310295315640284119991273070670322231185641301716722796994718708658822853529574504717202120087715634763424274962329123483461568296022257017023981450338465569919112063918042476700454021571171392482030319188836206919329803242195326633811637297253235487607751302250431320886381647212809702643152087561994984182249331503369542724758321007731386241330707705220946682121888543368358228612562325093075802578898941913821914982470062657123694012280941253428988753213467353262898239560386326402929813951118592433673882917967440359020916726667979115432611887029361669281497844588174502334233904813959323079315719030196049300573636670125591368001781071381882033633033075846767350209991643216843575217077034662358333634497570270352862341290034376432917058612596334047706875229266764781233862992588533927903452680367693882663546906997222149937115720060901314300242559793464548867207453042198041278383388974037550644314922384149422609551685749768703487278483854914212606653110110844638930693306976771821600172316737223489362354333311997609303844060758567208934005569629483129333307960247432117144204394463122 + 6.12246423496974006185614477885272567176745705888252123208952418877993155509740125665131331077503565236148081744580467529291376423106062734386452371317374766333752568364843953008234982250409405815138409841790537432345661999418660072812885115537811992387283828777865862983314801545830187201110845069318404334356811042626772011273784282368397049057890356631628030271888182958330461913203104116828531725007019825385323990249296993078614222419819473419754513768170314854475904772172582279773066267602988081971272488261394607768032054382038940495847396661162902158036823347579768330722899525248662831135830829221777939666697567980678414224549739851377138612122324424485742287053559075444924135768443480033939024848455804723313188322845604813263346692916116087667378748510471644100744623241769330718758374643109761351611638381564964109076278011208506544036289415830683326743819057100354222187486382601697169972890177386445395288317399936042147878617887885549384974606673077543110914720213649457922944284951450941199462532023194288585358636937287270603109719875286458329656953274799431740281017617925270955464464042057572801198831919610356761494417502079124908586468380892093752207893057297119026242275573167592521928910999818121433829366835707772501184925532464960430827451232842771928524230266036435915370913685273811898359301572447353638087240988621699959871385531914761395140341479868890643985148398351698681170443983096047041954834794166454281132053928324077832622041416435243516914362397881189420054509731*I)*q_1^3 + (-13.6006363034471046719715714108119334153261359036871396145200134549862033423646575010446288911033306832979848811801025960367458178086217328219136404533698943330195187575186092645050932790708519536351352855364016589896513936300232415438027401305754921019962457262025455918730937033954619038927234418724352625885491423734615491866183839685344955552440373936073990288468273243026975810406099877887355466896643250738231623673463935121829439107173574260933002493605509618325610351497900054884746238376349501261905429207927606124377900571821803082353484865896894180025174977326167006288654572457263112985251879040087732608417090964211261621873666285363609141819550534056273551379927226317577621590439283615861157961397384042538218791718380028160926101287126871734025007563678865382857904158697860868970793624242741070434794820398140221983513780023624736532388866119581798776670561795728130912640641374323778796488700954610733179620656975203998770989421175576731885631480413342037971996581144374366372229082756300310360292437838462953690434761387610607491633975506370155721736265564232400792083978936334311526172669914785790122046905702219654435229292036243778888556994796065196385999992507817314733506052918814578819942189618960484732935585799312382363536743655693725478801232991230231267536763574989580919998675055107765161984038179458941581427039022300102831945879034572947065764755454592220600552100680869038591452182013225740502297712234316843906682787279441969384658956817499423725738868030848998031113502 - 21.6947856813712743243228731803624399319759370454814692331065634955468550306583004107215677576987504005274350647548419756133998890646049348181467291854808602203693109775302238629357727626886303357196640301425786879452227175528258431686753732642376789223824971217718662960833262743203128008501116808085861823507633039684530814698959521450230201791664334165073881473216936161841545107966802658590527414437884115927096500922613098640296629170821694289330560583535597299193750169103998329458739892982196924580076593755760985196491964703439773750833013136032170635214310877519014933012318575543517424747048265082749948991231291070370099862483010529399885177606776298030713521568526791981096264397577805954214579815090429346656231062754017150859778273684849980641054670912557673887838976900224324944037942759128667093095951066234229954843335031791454106155373117532527785869403613174277247151154202018795671850384281432857137551098351710392539824788489115070141473502604244593364135864599623340712989247721375323797017864471655644267085769016900786727803087042495776821856926988776002781536104439326295788493186867707890824111730144643611505248314798886850827511372685635339021815351261594476873055375771277894222094943768530841248666439475929189652789262964280838780365549242094773588888029002197296160803282187892009937143765895162529457769694466131037375024903754518692970148285248802771528514958211569292493361455161390137505471054808536093941961482669938576835431696392771315798107856543164457874286774547*I)*q_1^4 + O(q_1^5)
```
The above code produces a basis of Eisenstein series in reduced row echelon normalization. We can also transform this basis to a canonical normalization where the leading order coefficient is 1 at one cusp and 0 at the remaining ones:
```python
sage: eis_canonical_normalization_list = res["q_expansions"][4]["eisenstein_canonical_normalizations"]
sage: eisforms_canonical = [sum(eisforms[i]*CC(e_j_canonical_normalization[i]) for i in range(len(eisforms))) for e_j_canonical_normalization in eis_canonical_normalization_list.values()]
sage: eisforms_canonical[0].O(5)
1 + (-0.248434402783301621303543463333241177744184346424437904583075239777665286480271475343139086119970954007289076003302407108795738116305837383799134614156847769237007437047143522783591814439469054885622932027490467857675351075524172795257493454407787815843128361657930779334751279556302346931317193616551094711124513456727286762333534233492206609008665231399420331020761020874592287497765056881083147739660750776927177782720656920078531356753704420262061542655611238728125279337800515296277396727990356159732338872364764229313901199587519541854687634793276251987937264541589305070210832898251043206135642029289158588314361010972023480143211644132682603653474904858245995841293396372235704054109346808250638281447418225425696311765665588233851369032855874513565526982218712556374900908312959403019996956157074366354673600997264122270792036281492428354542091652136893042640146979610672384887405517887034588038447444733770892212475460300059623581937538952738456324305679812425835790582064748151149678540146455304988896815962732284589518758021899039324856462297440955148028904816493185987698047667628104164323643532518275097088795506402979436724182970222570655503933103430530538206792823869315191953362464141023444295428461479587880331022540222103231223202252143474063256387796498936579188744543418267227866204638591073220617352861851934402453605828076245287002724515766151922120125908221885506731864827367741186471517441721002982162324945870264875644153890329573466126819111814159588634688540640989229762779929 + 0.110152429192373732081073070977164477263376703664247299661483416412293826355963895197223138481527215334127326304971527021223856906337670884836397338150483864463946447298096864014631582561508852949393813696431530726209277672400893454276829012844179869349206997442156472591740439579036060582124124248964406931969921079802140757795506678465176822443824558048582106306532316519867942856932343633032195498611842475377559156798488730673573762243903684579708518265278961185317387702818123486886389018665643895307436231872726900854560103633626644182644830814899285834487684656469640625532887367742339865336757780516019626022078626647658801521414481504679020272620882399017689790487092980203938451022725797005559679652313959516058536309271665450221309262999578936052100362584695595611583819523883173405255851208956620616207275027021641844337714095162147996433321954807024611205996751779123537168630799422405580245005031827508309380070299742427396686598585477807498964661133714821585579579056458639605350829917138030957445906955437311086316217100663167400457974428253220015101786931785276678391279203058268726963659099918541642941051783342156895924954691512605661443595777613820223831933240959917196053678486782117108167090099800649454311974052216918539626417775159130787502124728185018515955392628101370818563914376795244719226462162289235624727277508947696810988721889009940986849886148281962686458692601006828163586975100892911927486503225036239231698108342918339302256729047342449003347633583873570370266079660*I)*q_1 + (-0.939463366192208962851032495858967525694179974298307998957549442224916346226037254033341801608884198476671957239222968855015717712187377708121621235875238970239348901403138448493956259224304378301925825724461763439113822418073986749448582515372450388816962496456642835946853597366187687182207502834606956990964453929148765533415192547988199629379350488834680914268225337698639345049650239566586951981878052002614956722782912538835132786284009680914793242680300140474079031875025660627118863282665147880284522738324734724591087169935663560725942854718564238930424566934401427002803842011617253389861509019527181224534578147587012865758394005685264754278401166699379887338151787950054706668885798790124350394251576562766696205319109190466723494336776112691680958970910749495525211305254590013411512994266581792271871153828299362040677579278368705345116924402595512652118685077547183851072938548616695779576736835041871404874764780882856193802516868824751739874132153411748611127625955885783618049286182714682131124841663398226525777480799207086189543436774045444174137677574488132933844944068619915962436336669403058037731275535102618534297539198018551177148990425880293246311316795600421358761765151442245687659594985524057420122066643198860643584647769475931745144001969352064920488031880592873127950405399699436714015005498754079105261311137178735497732363734373459064427718095836302881967375905817917174866602602733546402067745160105235065158372459643482401966399047807652020418071499983910278492907157 - 2.04958446153383078859205539971654420764839146350872228166185195910941372018081156072779760215690669442429130548049665559369033050957830843884465556045627294750650912263462533894077990597023695012985792198590649420371218029789773459572933739747059412512226922193734427948035190672757290831790218764820585462581379790191472168300226308659335653179866790934937312407266532339196943773930692892883879890077297893503533434838553960888118084359430571789255902715579673177064410574554588133019426832730634041605948828200002369778326487003480693014282307010400742729462652006290255927981658817663936854240557186238591171766001693630506461053421189504266387006190592990735677621307846244373822659850399607034703306797509117406801823381950327815815799147872753411954301956825981540290071143048461197921110057268825158870780509968695990326396009539261474505126864853638578758591188022246185782163204884979952402978554313267021731446897982458996282381019997980552979660283935215955073806130208326818273891563992907077830605169442357243958458499726036262747632523293095754740299564360485779877217478947398643741608980100340697821280888086023603949224634968511124395047323724481484628860846280742158886327738489834363743004416154135214987046594198013822237158813224999901325631761244061089702917325295666612046163795875285826568328864186935897230819187844958984112493001972813329633176364627509581265275473508218690186523761731297060373220259357053242303070950890534924904723513895555327424497619669019719722594208609*I)*q_1^2 + (-5.59765928861225447116281154112870571980004693666486476181774338945631962881873318746301281686222823382023586024237661631173414840985073730662480008997974169248423566839863969242285331960405184715282042565347981848732133761804659179508712055595396188646427913699789662600995717391939670051677218586089517245870074496620208162199651121739104672019074430702757128354719327695517051106247471625754188755092082144469334031811300675947151685817202950540618572507639674976285103761519117797929469648580386827107657005397086708329576638033147229982510998178398127873119384661793534732776523932513293462256232638275553975082261462206470467608335878317676117431945023771164502440607301501738326914440382147207116281400899359804327851347803144282441877609920920019988241251071040261345708826576423232759845271747687064691298308830422851450724878415393302847313274437284085704401136008150286806776069440029993492801028831026758274946811555595968602206637406585985342735478765395617414723432050385147421513433427097787288192786374756284885068751331895854142148738463386551734600441097432440979907361966618433578689433976038834276873468140390456096180230523342616482273232062304971076677114704235258899548442966859204335023893999100548191223002433373951887992439772751045051599977989896793686816307342424042488589397715089852093256819681118023681934525966881572107226215329487845450779055405819171846492551330957395056274111547799483776251639729838575697997410828221510955475212787883674343448071330506508698957766694 + 9.21244830311781161102280865904153949962968882860759931052388948357817235977735289907795768982997901826689973489278079436255964638836004325229186159247081229584011141765805877484705890624624112475099738969808013807433945970995534808336708214633048293726742593682252554466972067011156383132836221964188528239397181700618597891085700958008301319708107075553584860525885776793817780249637677016557007691839303061686387707446237404836611754564787975121612023238042679503647586017706343449326968041976587177457293884920675913141283069934091803573137450965977152652251829787178085293009148123058231017210512014629348367391703051771037917447976933526514629669315155183675316930700866663892387873696761299250201683129164099160208450579456867234122126907306045932898376860455678042109882073219018066848359849633855872657983404474979619681937768190163470082270006561725055654069953636198282198880736370949571424547852518415933085478335247943419506548607513524413769863701922176896608642024957993651861280937091627098048348163271384837133063555036245355543842864858274536209824936540761613682557967410809666497227064003951282872530315590657009300506248369803415995180086300125079998994252632848542942997531605580216842181094108270829473261367674225427820745696600647657063811855209199164613337069474613520042624394277452285416586056044566416363732719390464642792121694684047183148146422331534481964694084556854275356692691740659193235671040466493920156694677405496276564019086285636356688342738099525825830898773187*I)*q_1^3 + (-31.7603835370495011323841464375079699801861653648942112827864418060329632375448406104788758064454582417222784872499277115032302650027340551932997314212864334657102685147402131849373669834984115953881869686602813680212974307167487485218076463738623433396233871158448605529186449205897731327724799148248836884071463592394720407284091407111210147140031058517362204015190519007440086891236181053879119242496943607700051520982936536673952528769668326545785403492261540174906375338122763549618808076632401245122953585836929514148097285778412557914905716365644458849207447066280323649805329377944930323694258790534211738748545421457536955181952662890162678813652202840118934682342985810512880302372913226828505656883519369568608095738820953824397180553720798897776093887878469066600048567856841799741668058234114919397133925813031819409113769925620626761673864676677698823464782965542298373517113784585322521232154996028475419618170276531513436669432894591345424041375244017292348061805652165018581815934834128422802129708068662140987767056360083130466857163326548671973993517104344858755539100526415450269808202919410690791049440140796213053245510529823648460171444228486610883376655464785627501585195942598239666463900075477479943120143511698787489646079901854147009009739094623468254507151830701921106444458021980757058186121566653334158571588112789175674179493512950240079822182981106621322962691927428235568689076231676252483514110729943152810904084093821848177127743325074884168074690780697435303072246423 - 13.6698733003149773451453129988794545458554808393923504330406166592592479491330399811634570242181588618767068356175578422593857429171340368180528348589787573146616562276861291653375567701443616237645857752863831269972631710035286728270667236831483957666959465613323090639360165945756231751640776435755689924881676957504122523896144089310212386567780283939270842476002650894472188813077679527065074141310366868515123879440895921796829971766303373136332656031386258100368371111683531913378780012340802290118978497619339587739145969940190326885915479451012174570973270254314529163905201377052109823810001334648025061790546078183084677836759878146155205662549909113654383752542872685530090857408283709407738287008343628595469638735701681774445429414734271056755627703852884730115121966748908596525596200169614226885841678779705555893906436513586083429764229482007409135507721294567032300939044487629248266769545453132157214939226545926204499996796479751428803068307059438898345575563844165030193856728721883231429946189966207839197468061005812608091162902811679060521293229589382343495311833241438045531426672218286915301878579285688686972875834670588669176216032964593512002856747966810075957212837267154094663836969782451528570097055522801274948313698126196145311448974482917679984277935021924447028023649126630999024579298090644527904446896221698065893472486377291509357819855792886354765945201947035892691689827083444767541417468986022505040645715645465747103858638548013094906963881240427335605339026037*I)*q_1^4 + O(q_1^5)
```
Interestingly, all of these coefficients seem to be non-algebraic!

#### Embeddings
The embeddings for this passport are given by:
```python
sage: res["embeddings"]
{('(1 6)(2)(3 4)(5 7)',
  '(1 7 6)(2 3 5)(4)',
  '(1)(2 3 4 5 6 7)'): 0.500000000000000 - 0.866025403784439*I,
 ('(1 4)(2)(3 5)(6 7)',
  '(1 5 4)(2 3 6)(7)',
  '(1)(2 3 4 5 6 7)'): 0.500000000000000 + 0.866025403784439*I}
```
where the keys denote the corresponding permutation triples and the values denote the corresponding embeddings of `K`.

#### Curve
Because `G` is a genus zero subgroup, we return the Belyi map defined over `L`
```python
sage: res["curve"]
(x^7 + (-124416/117649*w + 84155352/117649)*x^6 + (-73878612959232/96889010407*w + 17040459849847488/96889010407)*x^5 + (-15100525062717043802112/79792266297612001*w + 1284469587699483105566208/79792266297612001)*x^4 + (-1153774140393119937689759514624/65712362363534280139543*w + 20650122327624572811363374813184/65712362363534280139543)*x^3 + (-19288387923739755486941504377593004032/54116956037952111668959660849*w + 137626659388847497095686445882202423296/54116956037952111668959660849)*x^2 + (-116577732115280549606726366428096831269371904/44567640326363195900190045974568007*w + 419589978438228426855252785767090841163399168/44567640326363195900190045974568007)*x - 1653071878901176318811210447083391358924536602951680/256923577521058878088611477224235621321607*w + 3417382916626447735120505374939872050514159596470272/256923577521058878088611477224235621321607)/(x^6 + (-124416/117649*w - 3375504/117649)*x^5 + (356421980160/13841287201*w + 4741061630400/13841287201)*x^4 + (-408291631246540800/1628413597910449*w - 3546472866795141120/1628413597910449)*x^3 + (233778251778447169290240/191581231380566414401*w + 1490041917020662051368960/191581231380566414401)*x^2 + (-66906015607497700435027820544/22539340290692258087863249*w - 333370446406509703601981030400/22539340290692258087863249)*x + 7656731100141823971941851154350080/2651730845859653471779023381601*w + 31026919346920463795832693186625536/2651730845859653471779023381601)
```
For an example of a genus one (i.e., elliptic) curve, we consider the passport `9_1_1_1_0_0_a`
```python
sage: load("9/1/9_1_1_1_0_0_a.sage")
sage: res["curve"]
Elliptic Curve defined by y^2 + x*y + y = x^3 - x^2 - 95*x - 697 over Rational Field
```
