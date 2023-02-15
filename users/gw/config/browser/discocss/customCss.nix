{ colors }:

with colors; ''
:root {
    --font-family: "Roboto", "Blobmoji";
    --font-mono: "CaskaydiaCove Nerd Font";
    --font-size: 15px;

    --basebg: ${nbg};
    --base00: ${lbg};
    --base08: ${blk};
    --base07: ${gry};
    --base15: ${wht};
    --base16: ${dfg};
    --basefg: ${nfg};

    --base01: ${red_d};
    --base09: ${red};
    --base02: ${grn_d};
    --base10: ${grn};
    --base03: ${ylw_d};
    --base11: ${ylw};
    --base04: ${blu_d};
    --base12: ${blu};
    --base05: ${mag_d};
    --base13: ${mag};
    --base06: ${cya_d};
    --base14: ${cya};

    --button: var(--base08);
}

.theme-dark {
    --header-primary: var(--base07) !important;
    --header-secondary: var(--base07) !important;

    --text-normal: var(--basefg) !important;
    --text-muted: var(--base07) !important;
    --text-link: var(--base06) !important;

    --channels-default: var(--base07) !important;

    /* --brand-experiment: var(--base10); */

    --interactive-normal: var(--base07) !important;
    --interactive-hover: var(--basefg) !important;
    --interactive-active: var(--basefg) !important;
    --interactive-muted: var(--base07) !important;

    --background-primary: var(--basebg) !important;
    --background-secondary: var(--base00) !important;
    --background-secondary-alt: var(--base08) !important;
    --background-tertiary: var(--base08) !important;
    --background-accent: var(--base06) !important;
    --background-floating: var(--basebg) !important;
    --background-modifier-selected: var(--base00) !important;

    --elevation-high: none !important;
    --elevation-low: none !important;

    --guild-header-text-shadow: none !important;

    --channeltextarea-background: var(--base00) !important;

    --activity-card-background: var(--base00) !important;

    --deprecated-panel-background: var(--base00) !important;

    --chat-area-offset: 0px !important;

    --bold-font: var(--font-family) !important;
    --code-font: var(--font-mono) !important;
    --italic-font: var(--font-mono) !important;
}

* {
    border-radius: 0px !important;
    text-shadow: var(--base08) !important;
    -webkit-font-smoothing: antialiased !important;
    font-family: var(--font-family) !important;
    font-weight: normal !important;
    font-size: var(--font-size) !important;
    text-rendering: geometricPrecision !important;
    text-shadow: none !important;
    box-shadow: none !important;
    animation: none !important;
    animation-delay: 0s !important;
    animation-duration: 0s !important;
    -moz-tab-size: 1 !important;
    text-rendering: optimizeLegibility !important;
}

code {
    font-family: var(--font-code) !important;
    font-size: 15px !important;
}

:not(i) {
    font-family: var(--font-family) !important;
    font-weight: normal !important;
}

strong {
    color: var(--base10) !important;
    font-weight: bold !important;
}

span[class="item-2LIpTv"] {
    background-color: var(--base08) !important;
}

div[class="buttonContainer-1sjtPU"] {
    display: none !important;
}

[class="scroller-3X7KbA none-2-_0dP scrollerBase-_bVAAt"],
[class="scroller-3X7KbA none-2-_0dP scrollerBase-_bVAAt"]:hover {
    border-radius: 8px !important;
}

div[class="text-md-normal-304U3g"] {
    font-weight: bold !important;
    color: var(--base12) !important;
    background-color: var(--basebg) !important;
}

[aria-controls="newest-tab"], [aria-controls="oldest-tab"], [aria-controls="most_relevant-tab"] {
    color: var(--basebg) !important;
    background-color: var(--base06) !important;
}

[aria-label="Show User Profile"] {
    display: none !important;
}

div[aria-label="Update Ready!"] {
    display: none !important;
}

button[class="button-f2h6uQ lookBlank-21BCro colorBrand-I6CyqQ grow-2sR_-F"],
button[class="attachButton-_ACFSu attachButton-1ijpt9 button-f2h6uQ lookBlank-21BCro colorBrand-I6CyqQ grow-2sR_-F"],
div[class="expression-picker-chat-input-button buttonContainer-2lnNiN"],
[aria-label="Inbox"], [aria-label="Help"] {
    display: none !important;
}

[aria-label="Add Friend"],
[class^="circleIconButton"][class*="selected"] {
    background-color: var(--base02) !important;
    color: var(--basebg) !important;
}

[class^="peopleList"] {
    background-color: var(--basebg) !important;
}

div[class="none-2-_0dP scrollerBase-_bVAAt"],
div[class="banner-2boKnS panelBanner-13bsBR bannerPremium-86naOf reducedMotion-1TjCH2"] {
    background-color: var(--base00) !important;
}

div[class="defaultColor-24IHKz text-sm-medium-3Pz3rB"], div[class="iconWrapper-991FEf"] {
    color: var(--basebg) !important;
}

span[class="latin12CompactTimeStamp-2G5XJd timestamp-p1Df1m"] {
    margin-right: 10px !important;
}

div[id*="message-reply-context"] {
    margin-left: 15px !important;
}

span[class*="latin12CompactTimeStamp-2G5XJd"] {
    display: inherit !important;
    margin-right: 5px !important;
}

time {
    display: inherit !important;
}

div[class="usernameFont-2oJxoI username-vAneIW usernameSpeaking-3FKv6H"] {
    color: var(--base10) !important;
    font-weight: bold !important;
}

div[class="usernameFont-2oJxoI username-vAneIW usernameSpeaking-3FKv6H"]:hover {
    color: var(--basefg) !important;
    font-weight: bold !important;
}

div[class="scroller-Q9d9Di thin-31rlnD scrollerBase-_bVAAt"] {
    background-color: var(--basebg) !important;
}

div[class="scroller-Q9d9Di thin-31rlnD scrollerBase-_bVAAt"] strong {
    color: var(--basebg) !important;
}

::-webkit-scrollbar,
::-webkit-scrollbar-track,
::-webkit-scrollbar-track-handle,
::-webkit-scrollbar-track-piece {
    display: none !important;
}

div[class="inner-NQg18Y sansAttachButton-1ERHue"] {
    border-radius: 8px !important;
}

.message-2qnXI6:not(.mentioned-xhSam7):hover {
    background-color: var(--basebg) !important;
}

.autocompleteInner-zh20B_ {
    background-color: var(--base00) !important;
}

.selectorSelected-1_M1WV {
    background-color: var(--base08) !important;
}

.reactors-Blmlhw.thin-1ybCId.scrollerBase-289Jih.fade-2kXiP2 {
    background-color: var(--base07) !important;
}

.scroller-1-nKid.thin-1ybCId.scrollerBase-289Jih.fade-2kXiP2 {
    background-color: var(--basebg) !important;
}

.selected-1Tbx07.selectable-3dP3y-.base-1pYU8j {
    background-color: var(--basebg) !important;
}

[class*="reactions-"] .emoji {
    height: 20px !important;
    width: 20px !important;
    border: none !important;
    background-color: var(--base00) !important;
}

[class*="reactionMe"] {
    background-color: var(--base00) !important;
    color: var(--base08) !important;
    border: none !important;
    border-bottom: 3px solid var(--base10) !important;
    border-bottom-left-radius: 0px !important;
    border-bottom-right-radius: 0px !important;
}

.reactionMe-wv5HKu .reactionCount-2mvXRV,
.reactionMe-wv5HKu:hover .reactionCount-2mvXRV {
    display: inline-block !important;
    background-color: var(--base08) !important;
    color: var(--basefg) !important;
}

[data-list-item-id="private-channels-uid_48___nitro"] {
    display: none !important;
}

img[class*="avatar"], img[class*="replyAvatar"] {
    filter: none !important;
    border-radius: 64px !important;
    overflow: hidden !important;
    transition: none !important;
}

img[class*="avatar"]:hover {
    filter: none !important;
    transform: scale(1.1) !important;
}

div[class*="avatar"] {
    font-size: 10px !important;
    font-weight: bold !important;
}

div[class="keyboardShortcutsModal-2CRmCm"] {
    color: var(--basefg) !important;
    background-color: var(--basebg) !important;
}

.emojiItemDisabled-1FvFuF {
    filter: grayscale(100%) !important;
}

div[class*="groupStart-"] > [role="group"] {
    display: none !important;
}

div.size12-3R0845.marginBottom8-AtZOdT.bodyTitle-Y0qMQz:nth-of-type(3),
.scrollbar-3dvm_9.scrollbarGhostHairline-1mSOM1.input-cIJ7To.inputDefault-_djjkz.textarea-2r0oV8 {
    font-family: var(--font-family) !important;
}

#user-context-invite-to-server,
.colorDefault-2K3EoJ.colorBrand-ROmMP1.labelContainer-1BLJti.item-1tOPte,
[class*="guilds-"][class*="scroller-"] > [class*="listItem-"]:nth-last-child(-1n + 3) {
    display: none !important;
}

div[class="content-2hZxGK content-FDHp32 selectable thin-31rlnD scrollerBase-_bVAAt"] {
    color: var(--basefg) !important;
    background-color: var(--basebg) !important;
}

div[class*="keybindDescription"] {
    font-weight: bold !important;
}

div[class*="cooldownWrapper"] {
    font-size: 12px !important;
}

span[class="key-N5VmHN"], [class*="bindArrow"] {
    border-radius: 0px !important;
    color: var(--basebg) !important;
    background-color: var(--base06) !important;
}

[class*="colorBrand"] {
    color: var(--base06) !important;
}

[class*="colorDanger"] {
    color: var(--base01) !important;
}

[class*="lookBlank"] {
    color: var(--basefg) !important;
}

[class*="input"]:focus {
    border-color: var(--base06) !important;
}

[id*="popout"][class*="container"] {
    background-color: var(--basebg) !important;
    box-shadow: none !important;
    color: var(--basefg) !important;
}

[id*="popout"][class*="container"]::after {
    background-image: none !important;
}

[class*="live"][class*="textBadge"] {
    background-color: var(--basebg) !important;
    color: var(--base01) !important;
}

[class*="navButtonActive"] {
    background-color: var(--basebg) !important;
    color: var(--basefg) !important;
}

[class*="option"][class*="selected"] {
    background-color: var(--base00) !important;
}

[class*="resultsGroup"] * {
    color: var(--basefg) !important;
}

[class*="resultsGroup"][class*="filter"] {
    color: var(--basefg) !important;
}

[class*="resultsGroup"][class*="header"] {
    color: var(--basefg) !important;
}

[class*="peopleColumn"] {
    background-color: var(--basebg) !important;
}

[class*="section"] {
    background-color: var(--basebg) !important;
}

[class*="sidebar"][class*="container"][class*="header"] {
    background-color: var(--basebg) !important;
    box-shadow: none !important;
}

[class*="sidebar"] > [class*="container"],
[class*="members"][class*="scroller"] {
    box-shadow: none !important;
}

[class*="scrollerWrap"] {
    border-radius: 8px !important;
}

[class*="membersWrap"] {
    overflow: hidden !important;
}

[class*="chatContent"][class*="form"] {
    padding-top: 8px !important;
    background-color: var(--basebg) !important;
    box-shadow: none !important;
}

[class*="textAreaSlate"] {
    background-color: var(--base00) !important;
    border-radius: 8px !important;
    color: var(--basefg) !important;
    box-shadow: none !important;
}

[class*="textAreaSlate"] > * {
    border-radius: 8px !important;
    padding-left: 0px !important;
    padding-right: 0px !important;
}

[class*="userPopout"][class*="body"],
[class*="userPopout"][class*="footer"] {
    background-color: var(--basebg) !important;
}

[class*="userPopout"][class*="headerNormal"] {
    background-color: var(--base00) !important;
}

[class*="headerPlaying"] * {
    color: var(--basebg) !important;
    background-color: var(--base06) !important;
}

div[class*="separator"] {
    background-color: var(--base00) !important;
}

div[class*="textBadge"] {
    color: var(--basebg) !important;
    background-color: var(--base04) !important;
}

nav[class*="sidebar"] div[class*="item-3XjbnG selected-g-kMVV"],
div[class*="background-Gjdjzm selectedBackground"],
div[class*="premiumLabel-3HPvdB selected"] {
    color: var(--basebg) !important;
    background-color: var(--base06) !important;
}

div[class*="container-2nx-BQ"] {
    color: var(--basebg) !important;
    background-color: var(--base02) !important;
}

div[class="container-2nx-BQ"] {
    color: var(--basebg) !important;
    background-color: var(--base00) !important;
}

button[class*="lookFilled"] {
    color: var(--basebg) !important;
    background-color: var(--base12) !important;
}

button[class*="buttonActive"][class*="lookFilled"] {
    color: var(--basebg) !important;
    background-color: var(--base06) !important;
}

button[class*="lookLink"] {
    color: var(--basefg) !important;
}

[class*="sprite"] {
    filter: brightness(80%) sepia(80%) saturate(60%) !important;
}

[class*="newMessagesBar-"] {
    width: 50% !important;
    margin-left: 25% !important;
    opacity: 1 !important;
    border-radius: 8px !important;
    color: var(--basebg) !important;
    background-color: var(--base12) !important;
}

[class*="newMessagesBar-"] button {
    display: initial !important;
    background-color: var(--base12) !important;
    color: var(--basebg) !important;
}

[class*="barButtonMain"], [class*="barButtonAlt"] {
    color: var(--basebg) !important;
}

span[class^="expandedFolderBackground"] {
    background-color: var(--base08) !important;
}

[class*="pictureInPictureWindow"] {
    box-shadow: none !important;
}

[class*="divider"] {
    border-color: var(--base00) !important;
}

[class*="divider"][class*="isUnread"] {
    border-color: var(--base01) !important;
}

[class*="unreadPill-"] {
    background-color: var(--base01) !important;
}

[class*="unreadPillCap"] {
    fill: var(--base01) !important;
}

[class*="live"][class*="textBadge"] {
    background-color: var(--base01) !important;
    color: var(--basefg) !important;
}

[class*="modal"][class*="queryContainer-"],
[class*="modal"][class*="resultsGroup-"],
[class*="modal"][class*="bodyInner-"],
[class*="modal"][class*="quickMessage-"],
[class*="modal"][class*="inner-"],
[class*="modal"][class*="header-"]:not(header):not(h2),
[class*="modal"][class*="uploadModal-"],
[role*="dialog"] form {
    background-color: var(--basebg) !important;
}

[role*="dialog"] form [class*="footer"] {
    background-color: var(--base00) !important;
}

[class*="modal"][class*="sourceScroller"],
[class*="modal"][class*="segmentContainer-"][class*="segmentControl"] {
    background-color: var(--base00) !important;
}

[class*="modal"][class*="header"] {
    padding-top: unset;
    padding: 0.4rem;
}

[class*="modal"][class*="footer-"] {
    background-color: var(--base00) !important;
    filter: brightness(110%) !important;
}

[class*="panels"] > *:nth-child(2) {
    height: 4.6rem;
    padding-bottom: 0.5rem;
}

div[class*="chat"] div[class*="root"] {
    background-color: var(--basebg) !important;
}

div[class*="rtcConnectionStatus"] *,
[class*="circleIconButton"] {
    color: var(--base06) !important;
}

code.hljs:not(.inline)::before {
    opacity: 1 !important;
    font-family: var(--code-font) !important;
    font-weight: normal !important;
}

pre,code {
    font-family: var(--code-font) !important;
}

[data-list-id="people"] {
    margin-top: 0px !important;
}

a[aria-label^="unread"] {
    font-weight: bold;
}

h3, h1, h2 > div, div[class^="repliedTextPreview"] {
    font-family: var(--italic-font) !important;
    font-style: italic;
}

ul[data-list-id="guildsnav"] > div[class^="scroller"] {
    padding-top: 0 !important;
}

ul[data-list-id="guildsnav"] > div[class^="scroller"] > div:first-child > div {
    box-shadow: none !important;
}

ul[data-list-id="guildsnav"] > div[class^="scroller"] > div:first-child + div > div[class^="guildSeparator"], .pill-3N7f9r {
    display: none;
}

div[href="/channels/@me"]:not(:hover) > div {
    background-color: var(--basebg) !important;
}

.wrapper-1BJsBx.selected-bZ3Lue .childWrapper-anI2G9, .wrapper-1BJsBx:hover .childWrapper-anI2G9 {
    background-color: none !important;
}

.tutorialContainer-2sGCg9 {
    position: fixed;
    z-index: 1;
    background-color: var(--background-tertiary) !important;
}
.guilds-1SWlCJ .scroller-1Bvpku { contain: none !important; padding-top: 0;}
.guilds-1SWlCJ .scroller-1Bvpku > [aria-label], .guilds-1SWlCJ .scroller-1Bvpku > [style]:nth-child(2) { margin-top: 60px !important;}
.guilds-1SWlCJ .scroller-1Bvpku > [style] ~ [aria-label] { margin-top: 0px !important;}

nav[aria-label="Servers sidebar"] {
    margin-top: 30px !important;
    width: 70px !important;
}

.sidebar-2K8pFh {
    width: 240px !important;
}

.hljs {
    display: block;
    padding: 10px !important;
    overflow-x: hidden !important;
    scrollbar-width: 0px !important;
    background-color: var(--base00) !important;
}

.hljs,
.hljs-subst {
    color: var(--basefg) !important;
}

.hljs-deletion,
.hljs-formula,
.hljs-function,
.hljs-function .hljs-keyword,
.hljs-keyword,
.hljs-link,
.hljs-selector-tag {
    color: var(--base01) !important;
}

.hljs-built_in,
.hljs-emphasis,
.hljs-name,
.hljs-quote,
.hljs-strong,
.hljs-variable,
.hljs-type {
    color: var(--base04) !important;
}

.hljs-attr,
.hljs-params,
.hljs-template-tag {
    color: var(--base03) !important;
}

.hljs-builtin-name,
.hljs-doctag,
.hljs-literal,
.hljs-number {
    color: var(--base13) !important;
}

.hljs-code,
.hljs-meta,
.hljs-regexp,
.hljs-selector-id,
.hljs-template-variable {
    color: var(--base08) !important;
}

.hljs-addition,
.hljs-meta-string,
.hljs-section,
.hljs-title,
.hljs-selector-attr,
.hljs-selector-class,
.hljs-string,
.hljs-symbol {
    color: var(--base02) !important;
    font-weight: bold;
}

.hljs-attribute,
.hljs-bullet,
.hljs-class,
.hljs-meta-keyword,
.hljs-selector-pseudo,
.hljs-tag {
    color: var(--base06) !important;
}

.hljs-comment {
    color: var(--base08) !important;
}

.hljs-link_label,
.hljs-literal,
.hljs-number {
    color: var(--base05) !important;
}

.hljs-comment,
.hljs-emphasis {
    font-style: italic;
    font-weight: bold;
}

.hljs-section,
.hljs-strong,
.hljs-tag {
    font-weight: bold;
}
''
