# Bazzite-handleiding

Korte geheugensteun voor een nieuwe pc, dagelijkse backups en herstel.

## Wat komt automatisch mee?

Na installatie of overschakelen naar de persoonlijke Bazzite-image krijg je
automatisch:

- de aangepaste Bazzite-hostapps en hardware-integraties;
- Bazzites eigen standaardapps;
- Bitwarden, Vivaldi en LibreOffice via Flatpak.

De Flatpaks verschijnen zodra de pc internet heeft. Dit kan na de eerste
opstart enkele minuten duren. Je persoonlijke bestanden en appinstellingen
komen niet uit de image; die herstel je daarna uit Borg.

## Nieuwe pc: korte checklist

1. Installeer de persoonlijke Bazzite-image.
2. Gebruik dezelfde gebruikersnaam als op de oude pc.
3. Maak verbinding met internet en laat de automatische appinstallatie afronden.
4. Meld je aan bij Bitwarden.
5. Herstel je bestaande home met `ujust backup`, zoals verderop beschreven.
6. Herstart de pc en controleer je belangrijkste apps en bestanden.

De image staat op:

```text
ghcr.io/mightydisciple/bazzite-dx:latest
```

## Eerste backup van een pc instellen

Gebruik voor iedere actieve pc een eigen repository in BorgWarehouse.

### 1. SSH-key maken

Open een terminal:

```bash
ujust backup
```

Kies **1. Create or show BorgWarehouse SSH key** en kopieer de getoonde
publieke key.

### 2. Repository maken in BorgWarehouse

Maak in BorgWarehouse een repository voor deze pc:

- gebruik een herkenbare naam;
- plak de publieke SSH-key;
- kies een voldoende grote opslagquota;
- kopieer daarna de volledige LAN `ssh://`-URL.

Een URL lijkt ongeveer op:

```text
ssh://borgwarehouse@nas:2223/./repository-id
```

Gebruik altijd de exacte URL die BorgWarehouse toont.

### 3. Vorta instellen

Open Vorta via het applicatiemenu.

1. Voeg de BorgWarehouse-repository toe of initialiseer hem met de
   `ssh://`-URL.
2. Selecteer deze SSH-key:

   ```text
   /var/home/mightydisciple/.ssh/borgwarehouse
   ```

3. Kies versleuteling en maak een sterke repository-passphrase.
4. Bewaar de URL en passphrase onmiddellijk in Bitwarden.
5. Voeg je volledige home toe als bron:

   ```text
   /var/home/mightydisciple
   ```

6. Voeg de aanbevolen uitsluitingen toe:

   ```text
   /var/home/mightydisciple/.cache
   /var/home/mightydisciple/.local/share/Trash
   /var/home/mightydisciple/.local/share/Steam/steamapps/common
   /var/home/mightydisciple/.local/share/Steam/steamapps/shadercache
   /var/home/mightydisciple/.ssh/borgwarehouse
   /var/home/mightydisciple/.ssh/borgwarehouse.pub
   ```

7. Stel een dagelijkse planning en bewaarbeleid in.
8. Start de eerste backup handmatig en controleer in Vorta of het archief
   zichtbaar is.

De eerste backup duurt het langst. Latere backups bewaren alleen veranderingen.

## Gewoon iets terugzetten

Open Vorta, kies **Archives**, selecteer het gewenste archief en herstel alleen
het bestand of de map die je nodig hebt.

Voor een gewone fout hoef je dus niet je volledige home te herstellen.

## Volledige home herstellen op een nieuwe pc

Je hebt nodig:

- toegang tot BorgWarehouse;
- de repository-URL uit Bitwarden;
- de repository-passphrase uit Bitwarden;
- netwerktoegang tot de NAS.

Werkwijze:

1. Installeer de persoonlijke Bazzite-image met dezelfde gebruikersnaam.
2. Meld je aan bij Bitwarden.
3. Voer `ujust backup` uit en kies optie 1 om een nieuwe SSH-key te maken.
4. Vervang in de bestaande BorgWarehouse-repository de oude publieke key door
   de nieuwe.
5. Log volledig uit de desktop.
6. Ga met **Ctrl+Alt+F3** naar een tekstconsole en meld je aan als je normale
   gebruiker.
7. Voer opnieuw uit:

   ```bash
   ujust backup
   ```

8. Kies **2. Restore complete home**.
9. Vul de repository-URL en passphrase in en bevestig met `RESTORE`.
10. Herstart voordat je opnieuw op de desktop inlogt.

De oude SSH-key is niet nodig. De SSH-key geeft alleen toegang tot
BorgWarehouse; de passphrase ontsleutelt de backup.

## Wat is er kapot?

Gebruik de juiste herstelroute:

- **Kernel, driver of Bazzite-update kapot:** start de vorige Bazzite-deployment
  via het bootmenu. Borg is hiervoor niet nodig.
- **Persoonlijke instellingen of bestanden kapot:** herstel via Vorta/Borg.
- **Eén bestand verdwenen:** herstel alleen dat bestand via Vorta.
- **Volledig nieuwe of vervangen pc:** installeer de image en herstel daarna de
  volledige home.

Bazzite-rollback verandert je home niet. Borg-restore verandert het
besturingssysteem niet.

## Commando's om te onthouden

Er zijn maar twee persoonlijke menu's:

```bash
ujust backup
ujust workstation-virtualization
```

- `ujust backup`: BorgWarehouse-key, instructies en volledige home-restore.
- `ujust workstation-virtualization`: RTX-passthrough, KVMFR en Looking Glass.

Normale backups en losse restores gebeuren grafisch in Vorta.

## Bewaar dit in Bitwarden

- BorgWarehouse-webadres en account
- repository-URL van iedere pc
- repository-passphrase van iedere pc
- eventueel de naam van de repository en bijbehorende computer

De repository-passphrase is het belangrijkste geheim. Zonder die passphrase kan
de versleutelde backup niet worden geopend.

