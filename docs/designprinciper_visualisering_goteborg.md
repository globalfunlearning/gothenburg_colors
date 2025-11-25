# Designsystem för Datavisualisering – Göteborgs Stad

Detta dokument samlar principer och riktlinjer för att skapa tydliga, tillgängliga och professionella datavisualiseringar enligt Göteborgs Stads grafiska profil.

---

## Hur detta dokument används

Detta dokument definierar Göteborgs Stads standarder för datavisualisering och används som referens när vi utvecklar visualiseringar i R med hjälp av AI-assistenter.

**För AI-tjänster:** När du hjälper till med visualiseringar, följ dessa principer automatiskt. Varna om en förfrågan bryter mot de absoluta reglerna. Föreslå förbättringar baserat på grundprinciperna.

**För användare:** Referera till specifika principer när du ber AI om hjälp, t.ex. "skapa ett diagram enligt princip 6 (aktiva titlar)" eller "följ absolut regel 1 (nollbaslinje)".

---

## Innehåll

1. [Välj rätt visualiseringstyp](#välj-rätt-visualiseringstyp)
2. [Tabelldesign](#tabelldesign)
3. [Skapa effektiva visualiseringar](#skapa-effektiva-visualiseringar)
4. [Tillgänglighet](#tillgänglighet)
5. [Färg och typografi](#färg-och-typografi)
6. [Hantering av demografisk data](#hantering-av-demografisk-data)
7. [Absoluta regler för Göteborgs Stad](#absoluta-regler-för-göteborgs-stad)
8. [Krav på sanningsenlig visualisering](#krav-på-sanningsenlig-visualisering)

---

## Välj rätt visualiseringstyp

### Behövs det ens ett diagram?

Innan du skapar en visualisering, fundera över:

- **Kan budskapet förmedlas bättre med text?** Om en förklarande mening gör ett bättre jobb än ett diagram, skippa diagrammet.
- **Är en tabell bättre?** Om målet är att visa detaljerad information snarare än mönster, eller om det är viktigt att läsaren kan avläsa exakta värden, använd en tabell.
- **Räcker ett stort tal?** Ibland är en enda siffra i stor text ("632 000 invånare") mer effektivt än ett diagram.

### Val av diagramtyp efter syfte

| **Jag vill...** | **Lämpliga diagramtyper** |
|-----------------|---------------------------|
| **Jämföra värden eller rangordningar** | Stapeldiagram, punktdiagram |
| **Visa trender eller förändring över tid** | Linjediagram, områdesdiagram, stapeldiagram, slope charts |
| **Visa del-av-helhet** | Cirkeldiagram, staplade stapeldiagram, trädkartor |
| **Visa avvikelse från referenspunkt** | Bubbeldiagram, värmekarta, spridningsdiagram |
| **Visa fördelning av värden** | Histogram, boxplot, beeswarm |

**OBS:** Det finns inte alltid ett enda rätt val – ett stapeldiagram kan till exempel användas både för jämförelser och för att visa förändring över tid. Använd tabellen som utgångspunkt och anpassa efter sammanhang.

---

## Tabelldesign

### När är tabeller bättre än diagram?

- **När exakta värden är viktigare än mönster** - Läsaren behöver slå upp specifika tal
- **När data är för komplex för att visualisera tydligt** - För många dimensioner eller kategorier
- **När jämförelser kräver precision** - Diagram kan dölja små men viktiga skillnader

### Grundprinciper för tabeller

1. **Kolumnrubriker ska sticka ut** - Använd fet stil för att tydligt skilja rubriker från data
2. **Ljus skuggning för att separera rader eller kolumner** - Underlättar läsning av långa rader
3. **Vänsterställ text, högerställ siffror** - Följer läsriktning och underlättar sifferjämförelser
4. **Placera etiketter bara i första raden** - Undvik onödig upprepning
5. **Sortera data för att visa mönster** - Ordna efter värde, alfabetiskt eller logisk följd

### Korstabeller och orsakssamband

När du skapar tabeller för att visa samband mellan variabler:

- **Oberoende variabel (orsak) → kolumnrubriker överst**
- **Beroende variabel (effekt) → rader till vänster**
- **Beräkna procent vertikalt nedåt** - Varje kolumn ska summera till 100%

**Exempel:** I en tabell som visar effekt av vaccination ska "Vaccinerad/Ej vaccinerad" vara kolumnrubriker, och "Smittad/Ej smittad" vara rader. Beräkna procent så att varje kolumn (vaccingrupp) = 100%.

---

## Skapa effektiva visualiseringar

### Grundprinciper

**1. Håll det enkelt**
- Försök inte packa in alla datavärden i ett enda diagram
- Fundera på vad du vill att läsaren ska komma ihåg
- Du kan visa all data men lyfta fram en delmängd – till exempel använda grått för de flesta värden och färg för det viktigaste

**2. Var konsekvent**
- Om blå färg representerar en grupp i ett diagram, använd blå för samma grupp i alla diagram
- Konsistens gör det lättare för läsaren att förstå

**3. Small multiples (miniatyrserier)**
- Dela upp komplexa diagram i flera mindre diagram placerade nära varandra
- Alla diagram ska ha samma typ, storlek och skalor
- Ordna dem på ett meningsfullt sätt (efter värde, geografi eller alfabetiskt)

**4. Använd färg för att lyfta fram**
- Markera det viktigaste med färg (gärna rosa eller gul enligt Göteborgs profil)
- Låt övrigt vara grått eller blått
- Var selektiv – för många färger förvirrar

**5. Referenslinjer**
- Använd referenslinjer för att markera viktiga händelser, tröskelvärden eller riktmärken
- Se till att linjen är exakt placerad – till exempel mitt mellan 2010 och 2011 för juni 2010

**6. Aktiva titlar**
- Använd titlar som berättar vad diagrammet visar
- **Bra:** "Arbetskraftsdeltagandet har minskat för män och ökat för kvinnor"
- **Dåligt:** "Arbetskraftsdeltagande, män och kvinnor, 1950–2019"
- Använd underrubriker för detaljer om tidsperiod, enhet eller geografi

**7. Annotera**
- Lägg till förklarande text direkt i diagrammet för att lyfta fram specifika värden
- Förklara hur diagrammet ska läsas, särskilt för ovana läsare
- Till exempel: peka ut hur värdena ökar längs axlarna i ett spridningsdiagram

**8. Märk data direkt**
- Undvik förklaringsrutor (legends) när det är möjligt
- Märk istället data direkt i diagrammet
- Placera etiketter jämnt och på linje, inte utspridda

**9. Markera avvikare**
- Datavärden som avviker kraftigt kan vara intressanta eller signalera mätfel
- Var försiktig – förklara varför värdet avviker om det är känt

**10. Visa osäkerhet**
- Var tydlig när data saknas eller när det finns osäkerhet kring uppskattningar
- Förklara osäkerhet på ett sätt som passar målgruppen
- Exempel: "±4 procentenheter" för opinionsundersökningar

**11. Undvik 3D**
- 3D-effekter förvränger data och gör dem svårare att tolka
- Använd aldrig 3D om du inte har en tredje dimension att visa

**12. Var försiktig med datatransformationer**
- Logaritmiska skalor kan vara användbara men förvirrar många läsare
- Om du använder transformationer, förklara dem tydligt
- Överväg om procentuell förändring eller annan normalisering är bättre

---

## Tillgänglighet

Göteborgs Stad följer tillgänglighetskraven i lagen om tillgänglighet till digital offentlig service samt WCAG 2.1 nivå AA.

### Skriv alternativtext (alt-text)

**All visuell information måste ha textbeskrivning** för personer som använder skärmläsare.

**Riktlinjer för alt-text:**
- Beskriv **innehållet och funktionen**, inte bara vad bilden föreställer
- Fråga dig: Om jag tog bort bilden, vilken text skulle ersätta den?
- Om bilden är dekorativ (t.ex. en headerbild), lämna alt-text tom
- Undvik fraser som "bild av" eller "diagram som visar"
- Håll texten kort – helst under 160 tecken
- Undvik "klicka här" eller "läs mer" – beskriv istället vart länken leder

**Exempel på bra alt-text:**
- "Stapeldiagram som visar att befolkningen i Göteborg ökade med 12% mellan 2010 och 2020, medan Sverige totalt ökade med 9%"

### Säkerställ färgkontrast

**Kontrastkrav enligt WCAG 2.1 AA:**
- Normal text: minst **4,5:1** kontrast mellan text och bakgrund
- Stor text (18pt eller 14pt fet): minst **3:1** kontrast
- Göteborgs färgpalett är testad och uppfyller kraven – se [gothenburg_colors](https://github.com/globalfunlearning/gothenburg_colors)

**Viktigt:**
- Använd **endast svart eller vit text** mot färgad bakgrund
- Lägg till ytterligare kodningar (mönster, streck, former) om färg är enda sättet att skilja grupper åt
- Detta hjälper också färgblinda

### Undvik sammanslagna celler i tabeller

- Tabeller för skärmläsare får **inte** ha sammanslagna celler, tomma celler eller tomma rader
- Varje kolumn ska ha en egen rubrik
- Om du vet att produkten ska vara tillgänglig, bygg tabellen rätt från början

### Använd inbyggda formatmallar

- Använd Göteborgs mallar i Word/PowerPoint med förinställda stilar
- Skapa inte manuell formatering (tabbar, extra radbrytningar)
- Skärmläsare hanterar manuell formatering dåligt

### Skriv på klarspråk

**Klarspråk gör innehållet begripligt för fler:**
- Använd aktiv form i titlar och etiketter
- Förklara alla delar av diagrammet – det ska gå att förstå utan övrig text
- Undvik jargong och facktermer – eller förklara dem
- Utelämna onödiga ord – utrymmet är begränsat i diagram

**Ytterligare resurser:**
- [Do No Harm Guide: Centering Accessibility in Data Visualization](https://www.urban.org/research/publication/do-no-harm-guide-centering-accessibility-data-visualization)

---

## Färg och typografi

### Färgpalett

Göteborgs Stad har en **huvudfärg** (Göteborgsblå) och **14 komplementfärger** (7 mörka + 7 ljusa).

**Se detaljerad information:**
- [Göteborgs färgpalett på webben](https://kommunikation.goteborg.se/grafiskprofil/farg/)
- [R-paketet gothenburg_colors på GitHub](https://github.com/globalfunlearning/gothenburg_colors)

**Viktiga principer:**
- **Göteborgsblå (#0076bc)** används sparsamt för profilerande element, **inte** för datavärden
- Använd **mörka färger** för datavärden, grafer och kartfyllnad
- Använd **ljusa färger** för bakgrunder och highlights
- Kombinera färger med god kontrast
- Använd **max 7 kategorier** i ett diagram – fler blir svårlästa

**Färgkombinationer att undvika:**
- Rött/grönt (svårt för färgblinda)
- För många färger (blir plottrigt)
- Färgad text (använd alltid svart eller vit)

**När färg signalerar något viktigt** (t.ex. rätt/fel), komplettera med text eller ikon.

### Typografi

**Digitala kanaler (webb, interaktiva verktyg):**
- Rubriker: **Open Sans Extrabold**
- Brödtext och etiketter: **Open Sans Regular**

**Tryckta material (PDF, PowerPoint):**
- Rubriker: **Gotham Black**
- Brödtext: **Gotham Book**
- Längre texter: **Adobe Caslon Regular**

**Regler:**
- Använd **endast svart eller vit text**
- Skriv versalgement (inledande stor bokstav)
- Vänsterställ text – centrerad text endast för korta texter
- Skapa tydlig hierarki med storlek och vikter, inte färg

---

## Hantering av demografisk data

Göteborgs Stad strävar efter inkluderande och respektfull kommunikation i allt arbete med data om människor och grupper.

### Välj språk med omsorg

- Använd termer som är **inkluderande och respektfulla**
- Överväg att använda samma termer som i källdata (t.ex. SCB:s kategorier) **eller** välja andra termer som bättre speglar verkligheten
- Förklara dina språkval i en fotnot om det är lämpligt

**Resurser:** Se Göteborgs Stads riktlinjer för inkluderande kommunikation.

### Välj ordning på grupper

När du presenterar data uppdelat på grupper (kön, ålder, ursprung etc.), tänk på:

- Finns det en **naturlig ordning** (t.ex. åldersgrupper)?
- Finns det en **historia** du vill berätta med ordningen?
- Kan du sortera efter **storlek, alfabetisk ordning eller effekt**?
- Matchar ordningen **källdata**?

**Undvik:**
- Godtycklig ordning utan tanke
- Ordningar som förstärker stereotyper eller hierarkier

### Välj färger för grupper

- Följ Göteborgs färgpalett
- **Undvik färger som förstärker stereotyper** (t.ex. rosa för kvinnor, blå för män)
- **Undvik hudtonsfärger** när du visar grupper av människor
- Använd Göteborgs mörka och ljusa komplementfärger för bästa resultat

---

## Absoluta regler för Göteborgs Stad

Vissa designval ska **alltid** undvikas i visualiseringar från Göteborgs Stad.

### 1. Nollbaslinje i stapeldiagram

**Regeln:** Y-axeln i stapeldiagram (vertikala eller horisontella) **måste alltid börja på noll**.

**Varför?** Staplarnas längd blir missvisande om axeln börjar på annat än noll.

**Undantag:** Om små skillnader är viktiga att visa men en nollaxel gör dem osynliga, överväg att:
- Visa procentuell förändring istället
- Använda ett annat diagramtyp (t.ex. punktdiagram eller linjediagram)

**OBS:** Andra diagramtyper (spridningsdiagram, linjediagram) behöver **inte** börja på noll.

### 2. Dubbelaxeldiagram

**Regeln:** Undvik diagram med två Y-axlar där olika variabler hänger på olika axlar.

**Varför?** Dessa diagram är förvirrande, svårlästa och ofta vilseledande.

**Alternativ:**
- Flera diagram (horisontellt eller vertikalt placerade)
- Visa procentuell förändring eller annan normalisering
- Använd annat diagramtyp (t.ex. connected scatterplot)

**Undantag:** 
- Omvandlingar av samma värde (Celsius/Fahrenheit)
- Paretokurvor (värden som staplar + kumulativ summa som linje)

### 3. Cirkeldiagram med för många segment

**Regeln:** Använd **max 5 segment** i cirkeldiagram.

**Varför?** Människor kan inte jämföra olika segment i cirkeldiagram – det är svårt att se skillnader.

**När cirkeldiagram fungerar:**
- Segment som ger räta vinklar (25%, 50%, 75%)
- Tydliga proportioner där någon del är dominerande

**Alternativ:** Stapeldiagram eller punktdiagram för fler kategorier.

### 4. För många kategorier

**Regeln:** Använd **max 7 kategorier** i ett diagram.

**Varför?** Fler än 7 färger/kategorier blir plottrigt och svårläst.

**Lösningar:**
- Gruppera mindre kategorier till "Övrigt"
- Skapa flera diagram (small multiples)
- Visa bara de viktigaste kategorierna

### 5. Använd aldrig färgad text

**Regeln:** Text ska **alltid** vara svart eller vit – aldrig färgad.

**Varför?** Säkerställer tillgänglighet och läsbarhet.

**Undantag:** Inga. Detta är absolut.

---

## Krav på sanningsenlig visualisering

Alla visualiseringar från Göteborgs Stad ska uppfylla följande krav:

### Grundläggande krav

- **Visa data sanningsenligt** - Dölj inte relevant information eller manipulera för att vilseleda
- **Ange källor tydligt** - Länka eller referera alltid till datakällan
- **Erkänn osäkerhet** - Vid behov visa konfidensintervall
- **Dokumentera metod** - Spara anteckningar om datatransformationer och viktiga beslut

### Tre kategorier av visualiseringar

**1. Felaktiga visualiseringar**
- Bryter mot designreglerna (t.ex. stapeldiagram utan nollbaslinje)
- Återger data felaktigt
- Visar procentsatser som inte summerar till 100% i cirkeldiagram

**2. Vilseledande visualiseringar**
- Följer tekniskt reglerna men döljer eller vrider sanningen
- Använder olämpliga skalor för att dölja eller överdriva skillnader
- Manipulerar aspect ratio för att förändra upplevd trend
- Utelämnar relevant kontext som skulle ändra tolkningen

**3. Sanningsenliga visualiseringar**
- Visar data korrekt och följer designreglerna
- Ger kontext som behövs för rätt tolkning
- Erkänner begränsningar i data

**Mål:** Skapa visualiseringar i kategori 3, med fokus på högsta kvalitet inom denna kategori.

---

## Sammanfattning: Grundprinciper för bra visualiseringar

1. **Tänk efter innan du börjar** – Behövs ett diagram, eller duger text/tabell?
2. **Välj rätt diagramtyp** för ditt syfte
3. **Håll det enkelt** – inte för mycket på en gång
4. **Var konsekvent** – samma färger och stilar i alla diagram
5. **Gör det tillgängligt** – kontrast, alt-text, klarspråk
6. **Använd färg med omsorg** – följ Göteborgs palett, markera det viktiga
7. **Märk direkt i diagrammet** – undvik förklaringsrutor när det går
8. **Skriv aktiva titlar** – berätta vad diagrammet visar
9. **Respektera människor i data** – inkluderande språk och genomtänkta val

---

## Resurser och verktyg

**Göteborgs grafiska profil:**
- [Färg](https://kommunikation.goteborg.se/grafiskprofil/farg/)
- [Typografi](https://kommunikation.goteborg.se/grafiskprofil/typografi/)

**R-paket för Göteborgs färger:**
- [gothenburg_colors på GitHub](https://github.com/globalfunlearning/gothenburg_colors)

**Inspiration och fördjupning:**
- [Datawrapper Academy](https://academy.datawrapper.de/)
- [Do No Harm Guide: Centering Accessibility](https://www.urban.org/research/publication/do-no-harm-guide-centering-accessibility-data-visualization)

---

*Senast uppdaterad: 2025-11-22*
