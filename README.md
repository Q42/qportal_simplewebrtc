Qportal - SimpleWebRTC
====================
 <h1>/admin</h1>
<p>
Op de admin pagina kunnen twee locaties toegevoegd worden (in ons geval Amsterdam & Den Haag).<br /> 
Er is een limiet van twee locaties. Meteor houd deze bij in de collection locations.<br />
Ook kunnen er schermen worden toegevoegd, bijvoorbeeld Q020 - Keuken. Meteor houd deze bij in de collections screens.<br />
Een scherm kan worden gekoppeld aan een locatie door op een scherm te klikken en vervolgens op de naam van de locatie.<br />
Standaard worden schermen aan elkaar gekoppeld op basis van volgorde dus het scherm op positie 1 onder Amsterdam wordt gekoppeld aan het scherm op positie 1 onder Den Haag <i>(moet nog op een 'nettere' manier gebeuren!)</i> <br />
Deze schermen krijgen dezelfde 'room'. Waardoor deze in feite gekoppeld zijn. <br /><br />
<i>Het zou mogelijk zijn om alle streams 1 room toe te wijzen, echter bij meer dan 5 'peers' worden de verbindingen onbetrouwbaar.</i></p>
<ul>
<li><i>streams die afgesloten zijn blijven zichtbaar als zwarte schermen</i></li>
<li><i>duurt lang voor een stream aan de room is toegevoegd</i></li>
</ul>
<p>
<i>Om die reden is er gekozen om twee schermen hun eigen room te geven.</i>
</p>

<h4>/client/admin</h4>
<ul>
<li>admin.coffee</li>
<li>admin.html</li>
<li>admin_model.coffee</li>
</ul>

<h1>/portal</h1>
<p> Om een videoverbinding op te zetten kan naar /portal worden genavigeerd. <br />
Hier staat een lijst van schermen (die onder /admin is aangemaakt en gekoppeld aan een ander scherm).<br />
Selecteer het scherm en klik vervolgens op allow (auto allow is mogelijk over een beveiligde verbinding) om het streamen te starten.<br />
Indien de tegenhanger aan het streamen is zal zijn webcamstream zichtbaar zijn, zo niet is er een leeg scherm waar uiteindelijk de remote stream in komt zodra deze wel beschikbaar is. </p>

<h4>/client/portal</h4>
<ul>
<li>portal.coffee</li>
<li>portal.html</li>
<li>portal_model.coffee</li>
</ul>

<b><u>SimpleWebRTC</u></b><br />
<a href="http://simplewebrtc.com/">SimpleWebRTC Documentatie</a>
<p>
Wordt gebruikt voor de videostream (portal.coffee).<br />
Er wordt een SimpleWebRTC object aangemaakt met als parameters de DOM elementen voor de local video (eigen video stream), en de remote stream.<br /></p>
<ul>
<li>webrtc.on('joinroom') -> de room die we joinen</li>
<li>webrtc.on('videoAdded') -> wanneer een remote peer verbind en zijn video is toegevoegd aan de DOM</li>
<li>webrtc.on('localstream') -> wanneer de local stream beschikbaar komt, wordt gebruikt om de microfoon te muten zodra we een local stream hebben</li>
</ul>

<b><u>keyBinds</u></b>
<p>De vaste knoppen zijn eigenlijk toetsenborden: <br />
<u>Wanneer de knop is ingedrukt -> Q </u><br />
Unmute de microfoon voor 20 seconde en zet een readyToTakeOver waarde op false.<br />
Deze waarde weerhoud een ander scherm van verbinden zodra dit andere scherm met ons scherm wilt verbinden (door middel van nextScreen)<br />
Er word een melding getoont dat het scherm in gebruik is.<br />
Er begint een timer te lopen van 20 seconde, wanneer deze tijd verstreken is word de microfoon weer gemute en de readyToTakeOver op true gezet. Nu zou een ander scherm kunnen verbinden met dit scherm</p>

<p><u>Wanneer de knop word losgelaten -> A</u><br />
Geen actie aan gekoppeld.</p>

<p><u>Pijltjestoetsen</u><br />
Wanneer de pijltjestoetsen (rechts en links) worden ingedrukt gaan we naar het volgende scherm <i>(previous scherm is nog niet gebouwd)</i>.<br />
Indien het scherm niet bezet is (readyToTakeOver) word er een temp + schermId roomname aangemaakt en 'joinen' beide schermen deze room.<br />
Zodra we op een pijltjestoets drukken en weer naar het volgende scherm gaan krijgt het huidige scherm zijn defaultRoomName terug en word het volgende scherm in de tijdelijke room geplaatst.<br />
Zodra we terug komen bij onze originele tegenhanger wordt onze room weer op de defaultRoomName waarde gezet.</p>

<p><b><u>Tablets</u></b><br />
Wanneer er op het scherm geklikt word (dmv. mouseclick) wordt fullscreen aangezet. Wanneer fullscreen al aan is kan na weer tappen de microfoon geunmute worden.</p>

<p><b><u>Meteor</u></b><br />
<a href="http://docs.meteor.com/">Meteor Documentatie</a><br />
<u>screens:</u><br /></p>
<ul>
<li>_id -> Het ID van een scherm </li>
<li>defaultRoomName -> Is de room die zijn originele tegenhanger ook als defaultRoomName heeft (bijvoorbeeld Q020 - Keuken en Q070 - Keuken zijn 'default' tegenhangers van elkaar).</li>
<li>isTalking -> Boolean die we bijhouden zodra een scherm praat is deze true anders false - kan gebruikt worden om gebruiker feedback te geven dat de microfoon van de tegenhanger geunmute is. (word op dit moment niks mee gedaan)</li>
<li>location -> Het id van de locatie</li>
<li>name -> Naam van het scherm</li>
<li>readyToTakeOver -> Boolean die bijhoud of we met het scherm kunnen verbinden bij false toon een bericht dat het scherm in gebruik is bij true kan er met het scherm worden verbonden</li>
<li>room -> De room waar het scherm zich in bevind, deze wordt aangepast zodra we naar een ander scherm navigeren (met nextScreen bijvoorbeeld)</li>
<li>sessionId -> Sessie ID die de stream van SimpleWebRTC krijgt. (word op dit moment niks mee gedaan)</li>
</ul>

<p><u>locations:</u></p>
<ul>
<li>_id -> ID van de locatie</li>
<li>name -> naam van de locatie</li>
</ul>

<p><b><u>CoffeeScript</u></b><br />
<u>syntax:</u><br />
<a href="http://coffeescript.org/">CoffeeScript</a>
</p>