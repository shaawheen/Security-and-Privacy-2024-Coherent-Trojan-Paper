[33mcommit 3f71b0af742a2d8eede54cb2431dcdb55645b57e[m[33m ([m[1;36mHEAD -> [m[1;32mfeat/devil_DUT[m[33m, [m[1;31morigin/feat/devil_DUT[m[33m)[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 28 13:27:41 2023 +0100

    sim: Add project to test/simulate devil-in-the-fpga
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit b391bd41c82f1f57a1d1815419d5df81b76f73cc[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 28 11:12:47 2023 +0100

    test: (Undo) Skip one snoop reply
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit 95668bc0f73b0f5f81d94b2da10963b5a836e341[m[33m ([m[1;31morigin/feat/ip_refactoring[m[33m, [m[1;32mfeat/ip_refactoring[m[33m)[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 19:47:13 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 4141c2a99e2b9d50ae9ce73cfa747325e1295c7e[m
Merge: 50937f7 9c6cc68
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 19:28:23 2023 +0100

    Merge branch 'feat/ip_refactoring' of https://github.com/ESCristiano/devil-in-the-fpga into feat/ip_refactoring

[33mcommit 50937f73338683df393389290099dbaebdf7a918[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 19:28:17 2023 +0100

    test: Skip one snoop reply
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit 34ee7a027d2741a15707abc2885d1ca5379a987f[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 15:40:10 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 9c6cc68af647f6ed6c4fa18e160cff6d4fa51105[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 15:40:10 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 67869bdd7ba1d5b4462194980524b29780f73636[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 15:00:58 2023 +0100

    fix: acready devil never asserted
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit 4f04eee429dd75367de06b3f07c2782b937c4a67[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 14:33:34 2023 +0100

    update(bitsrteam): bitstream

[33mcommit fbbf57e4887a2b1f4af8da5bb276300e765a5add[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 12:19:43 2023 +0100

    fix: Overlapping acready signl high between backstabber and devil
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit 7b008cd8e69f5ed3547abb34c93d6d03f583b077[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 12:08:29 2023 +0100

    fix: Overlapping acready signl high between backstabber and devil
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit eec47424ae1a2de0e11758a76afb9248ae29e87a[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 11:44:28 2023 +0100

    fix: Overlapping acready signl high between backstabber and devil
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit 6a17491c140573ebc481e3a130a0b929697e99b5[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 11:25:29 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 2a3ce067dbdb2f04296830db68468814ede515f0[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 09:33:16 2023 +0100

    fix: Always exiting DEVIL_EN, wrong exit condition
    
    Signed-off-by: ESCristiano <cris96r@gmail.com>

[33mcommit bf0598fc709449eb1c076f2d17092e767d7bf463[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 08:59:47 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 18a652b48dbc7976cd8075174684e40812e29825[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 08:37:23 2023 +0100

    fix: devil acready on only in DEVIL_EN state

[33mcommit e5364307088ef6b301832feb3211c580d9217105[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 19 07:53:19 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 0b6a3cb2584edc8ade9cb4c5b2cb5079ab5c3e8e[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sun Jun 18 13:13:07 2023 +0100

    Feat: Add signal to indicate a snoop response reply

[33mcommit 26c5ef77f5c954f0e9ade77b99b64485ba6dd85b[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sun Jun 18 12:57:14 2023 +0100

    Feat: Add END_REPLY state

[33mcommit 190f3d5f1b613694e13db8e3425f286d54b6d4f5[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sun Jun 18 11:52:09 2023 +0100

    Feat: Add central handshake

[33mcommit b002f9dce1ba467cedf3d95037d39acd3572a410[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 17 15:21:23 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 4a76b937583287bfc2dd285ec16da4d1361a9f25[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 17 11:58:33 2023 +0100

    Feat: Add some extra signals to the ILA

[33mcommit 575f1f62e5be4af09533c37e0ef0ef74e448bc56[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 17 11:24:00 2023 +0100

    Fea: Add dummy reply state and enforce snoop response  handshake

[33mcommit 27031c6130923579695d42ca758fac337745a47f[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 16 11:29:11 2023 +0100

    update(bitsrteam): bitstream

[33mcommit c381dc3614e55ea3c4745ed9e23387555474d26d[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 16 11:03:03 2023 +0100

    feat(ip refactoring): Fix devil start condition.

[33mcommit 21bdac68f4a2807fa4ff5712e445753defd4b67f[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 16 10:46:26 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 58d98c99588bb41c25639de6cc3a9c2bd1c5ed3c[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 16 10:28:48 2023 +0100

    feat(ip refactoring): Add bit to prevent multiple functions executions in one Devil FSM iteration

[33mcommit c3391b804a88cfbb752e9c9bc4d2ae8fc41a24fb[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 16 09:38:30 2023 +0100

    feat(ip refactoring): Add Ac and Addr Filter

[33mcommit d085ddf37ce4c6a375d80c4ab0dc140cbba2d8d3[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 14 16:21:04 2023 +0100

    feat(ip refactoring): Test Bench to stimulate OSH and CON devil functions

[33mcommit b9bef27bce3ccd58151732a809968d23531cf0c7[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 14 10:41:20 2023 +0100

    update(bitsrteam): bitstream

[33mcommit fbb8fe4c1a7ca680f6562adcb3c91733ad152ada[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 14 10:20:30 2023 +0100

    feat(ip refactoring): Fix some verilog erros, backsttaber

[33mcommit 2df9caa732b784cb59f8d8427a6dd5dcee3278b2[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 14 09:46:19 2023 +0100

    feat(ip refactoring): Updgrade Design tcl scripts

[33mcommit 392108a6aeec022ef0cf030d4b25a7bad5813eeb[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jun 14 08:42:26 2023 +0100

    feat(ip refactoring): Continuous Delay Function

[33mcommit 6b0bef9415bbd677dbecb406b47d1808384edccb[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Jun 13 19:15:21 2023 +0100

    feat(ip refactoring): Add devil_in_fpga module | Test Bench | One Shot Function

[33mcommit 9a0c6fde302a1295ab45367a4a075f702f3d1186[m[33m ([m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 12 15:02:05 2023 +0100

    feat(permanent failure): Backup

[33mcommit b1cd6a8e732caee1a7d36ad7f222d62fa14dcfc8[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 15:04:37 2023 +0100

    feat(firmware): Enable outer shareable

[33mcommit 08a566ca2ba7c9733fcbae1b3daf47a095d08b6d[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 14:59:03 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 2a84868c51578d00b7b41e786aa60848a5c32af9[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 14:38:14 2023 +0100

    update(bitsrteam): Do bitstream server

[33mcommit 49782a43c8eee3d4c3da225f6e2a33947b776c87[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 14:12:52 2023 +0100

    update(bitsrteam): bitstream

[33mcommit 1bce0d72765cb6695b86127bfaee04273c3dc5f5[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 12:44:25 2023 +0100

    update(bitsrteam): Do bitstream server

[33mcommit 5516b96ed29e251b591dc68df533d5c32b07df7d[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Fri Jun 9 11:26:53 2023 +0100

    update

[33mcommit 793de28b284f7e5fec783af2e2df2d1b8cb1257b[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Jun 6 16:19:58 2023 +0100

    feat(hw): Update hw to respond to all snoop requests

[33mcommit c2e79d1ded498bdd7b6df1b2976607f47328d781[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 5 16:16:52 2023 +0100

    feat: Update README

[33mcommit 11f3892648ca662d66300705efa944e7dac97298[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 5 16:14:40 2023 +0100

    feat: Update README.md

[33mcommit 75546169f4fb96d017a095b0d0ddcf86a15d50dd[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon Jun 5 16:14:07 2023 +0100

    feat: Update README.md

[33mcommit 59b7b14dbb633ed512ab209b86e755f87170fbb6[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 3 17:10:36 2023 +0100

    feat: Add RT-bench code

[33mcommit 219b42a1898d303ffe592e75b8397317c9f044b2[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 3 10:40:40 2023 +0100

    feat: Add artifacts.nix

[33mcommit 92365cce89f435807552f5d992c88f04dbc73179[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Sat Jun 3 10:15:55 2023 +0100

    feat: Add baremetal tailored for this experiment

[33mcommit f8b676847ddac5432470858d5e6f8892c8a0a058[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue May 30 15:21:42 2023 +0100

    feat: Update Readme

[33mcommit b26fdf6c8e8e8c7862b7373cba285002cd414d97[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue May 23 16:15:39 2023 +0100

    feat: Linux with IPC patch

[33mcommit dd8332409a39e8a95f370d63cc41a13b15a25394[m
Author: Diogo21Costa <53279352+Diogo21Costa@users.noreply.github.com>
Date:   Tue May 23 16:13:30 2023 +0100

    fix(script): Avoid script error if backstabbing_devil does not exist

[33mcommit 5f41581c2f2b418bd02c3f29ee32689831d53912[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue May 23 12:14:19 2023 +0100

    feat: Add atf patch and backstabbing bitstream

[33mcommit 19013d7fd8aeb394a6de5eb1fef8b437497d80af[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Mon May 22 12:03:55 2023 +0100

    feat(nix): Add software artifacts built with nix

[33mcommit 7e62e41b784c364fbc35aa9612abb4a4e0f14c60[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 18:46:31 2023 +0000

    FIX(Intermitten Failure/state machine): reply with delay crvalid, cdvalid, cdlast

[33mcommit f0298d157d163ec6ff300e73787da715ca4d0b66[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 17:47:42 2023 +0000

    Intermittent Failure: bitstream

[33mcommit 765aed4b9a9615126a5c24d0220c05c3a2a1c3bc[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 17:27:01 2023 +0000

    Intermitten Failure: reply with delay crvalid, cdvalid, cdlast

[33mcommit 88793f8085ea67512b9a0f0802b9fedd06d9bf03[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 16:11:08 2023 +0000

    Intermitten Failure: reply with delay crvalid, cdvalid, cdlast

[33mcommit 8eedd88f432fe6003dcab454b2754575dad03113[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 15:14:50 2023 +0000

    Intermitten Failure: reply with delay crvalid, cdvalid, cdlast

[33mcommit b1b112d705a55b54c604a20d43c26527bbdf43fd[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 09:36:33 2023 +0000

    Intermittent Failure: bitstream

[33mcommit 1eaf399cadfaf72eb8b584fa8995ea5b0fe18f4a[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Jan 11 09:14:00 2023 +0000

    Intermitten Failure: reply with delay

[33mcommit e20c317195ad41cc99a575efe05fe7707b0f23c7[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Jan 10 11:45:16 2023 +0000

    Intermittent Failure: bitstream

[33mcommit db37f896699a643410012a763cc22a82720858f5[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Jan 10 11:26:27 2023 +0000

    Intermitten Failure

[33mcommit 3feee73061ceb980dae8a935dead0ea7d7c5b96b[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Jan 10 10:53:45 2023 +0000

    bitstream

[33mcommit ce55054329c1cd28d8c5e4673814253b97541a89[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Dec 1 13:14:57 2022 +0000

    Fuzzing: bitstream

[33mcommit d876070e044649bdea881d4098b7b21f25389205[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Dec 1 12:54:42 2022 +0000

    Fuzzing: ClenaInvalid

[33mcommit 16b602cbdf1c35b86f1af6f2ee2984b2ea0ceb2c[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Dec 1 11:32:43 2022 +0000

    Fuzzing: bitstream

[33mcommit 5de25ba4f7c5af929181de4870b550513a5fe092[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Dec 1 10:57:29 2022 +0000

    Fuzzing: ClenaInvalid

[33mcommit b1628521fa1fe081fb6e81538a3d3c70d0d3d0c2[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 30 12:03:26 2022 +0000

    DVM Fail: Debug Nets

[33mcommit c72002fd7e435be708d16235938cd37124d7ceba[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 30 12:01:15 2022 +0000

    FSM FAIL by state

[33mcommit 831b20b3d41a891bd384e582100741e6737ede3e[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 19:19:41 2022 +0000

    DVM Fail: Bitstream

[33mcommit b1aea599f0c58b8016361849d5096f33a1224875[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 17:56:12 2022 +0000

    FSM FAIL by state

[33mcommit 5b06d782b5a1f79c94aedd7c66a39b2d410baf4d[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 17:26:17 2022 +0000

    DVM Fail: Bitstream

[33mcommit 2964149632faceaa98602cc8833800ab302d1f05[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 16:45:10 2022 +0000

    DVM FAIL: Not sync || Not Last

[33mcommit ab354d2ea0ab37ab183eaab541b229cb870d2a95[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 11:00:33 2022 +0000

    Backstabber: Bitstream

[33mcommit 9643236e8c18ee2c337082eb6635ae643f822d09[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 10:15:28 2022 +0000

    Backstabber: Add AXI-Lite Interface & Disable FSM

[33mcommit 3e0f24ef0111ecebfff6a8a9194a4d5697525ba6[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Tue Nov 29 10:14:18 2022 +0000

    Backstabber: Add AXI-Lite Interface & Disable FSM

[33mcommit 563844467c8683c05519c40b72cf9f646fa44b4e[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Nov 17 15:52:50 2022 +0000

    protocol failure

[33mcommit 259211bc2ecbd28ac187ab9053617ee4e4f166e5[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Nov 17 15:11:02 2022 +0000

    Backstabber: upgrade

[33mcommit 6792cf030f34309edaa198594810bfebdf79252a[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Nov 17 14:41:45 2022 +0000

    protocol failure

[33mcommit d18f8ef60bf6fd5beb02fc9d9eff3b66829e5538[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Thu Nov 17 09:39:17 2022 +0000

    Backstabber: Wrong command

[33mcommit b04e5c3439621fe34390ba720ebe1d21e75fbb6b[m[33m ([m[1;32mmain[m[33m)[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 19:36:45 2022 +0000

    udpate scripts

[33mcommit cfe09a8db87870fa891ed33e7bdd5df71047f068[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 19:16:36 2022 +0000

    Update design.tcl

[33mcommit ca59c1c1eb883f0bc7763838a9caef39940ac1ee[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 16:28:53 2022 +0000

    Initial commit

[33mcommit 36b9385b496336a769524a6807fd9d4bc2d7be2d[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 16:19:03 2022 +0000

    Initial commit

[33mcommit 1f3528a85eb63d661ff39db6e305ff9fb715d812[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 16:17:54 2022 +0000

    Initial commit

[33mcommit 4857e3af0e561039317c8e8f901742185e6325de[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 16:15:11 2022 +0000

    Initial commit

[33mcommit 3acd3bf5078fbaf34b1c87b9985a22170fb86d8e[m
Author: ESCristiano <cris96r@gmail.com>
Date:   Wed Nov 16 16:12:31 2022 +0000

    Initial commit

[33mcommit b31cc7ad9c8b88865bf4c279d6920f13214be35c[m
Author: Cristiano Rodrigues <33751144+ESCristiano@users.noreply.github.com>
Date:   Wed Nov 16 15:39:44 2022 +0000

    Initial commit
