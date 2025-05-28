<p align="center">
  <a href="https://github.com/cortez24rus/marzban-sub" target="_blank" rel="noopener noreferrer">
    <img src="PreviewTemplate.png" title="Marzba-Sub"/>
  </a>
</p>

marz-sub.sh support [marz-reverse-proxy install script](https://github.com/cortez24rus/marz-reverse-proxy) & [xray-vps-setup](https://github.com/Akiyamov/xray-vps-setup/)

# Table of Contents
- [Attributes](#Attributes)
- [marz-sub.sh](#marz-subsh)
- [Installation Steps](#Install-Steps)
- [Default Language](#Default-Language)
- [Personalization](#Personalization)
- [Host Version](#Host-Version)

# Introduction
A simple html template to better display user information

# Attributes
- Quickly add subscription links to programs
- The link to download the required applications
- Three languages (Russian, English, Persian)
- Sub fantasy page with beautiful color and glaze
- Receive the configs with the copy icon at the bottom of the page

# marz-sub.sh
- marz-sub.sh include this web templates:
  - [fork marz-sub](https://github.com/cortez24rus/marz-sub/)
  - [marzbanify-template fork by legiz](https://github.com/legiz-ru/marzbanify-template)
  - [marzban-sub-page by streletskiy](https://github.com/streletskiy/marzban-sub-page)
  - [fork marz-sub by sm1ky](https://github.com/sm1ky/marzban-sub)
  - your link template
- sing-box client config based on:
  - [secret-sing-box](https://github.com/BLUEBL0B/Secret-Sing-Box/) (relevant for Russia)
  - [Skrepysh](https://github.com/Skrepysh/tools/blob/main/marzban-subscription-templates/sing-sub.json)
  - your link template
- mihomo (Clash Meta) client config based on:
  - [example config with proxify only ru-bundle rule-set](https://github.com/legiz-ru/mihomo-rule-sets/) (relevant for Russia)(if you need use another rule-sets you can uncommented or add new rules in /clash/default.yml)
  - [Skrepysh](https://github.com/Skrepysh/tools/blob/main/marzban-subscription-templates/clash-sub.yml)
  - your link template
- xray config:
  - by legiz
  - your link template
# Installation Steps
1. Run script
```sh
bash <(curl -Ls https://github.com/legiz-ru/marz-sub/raw/main/marz-sub.sh)
```

2. Restart Marzban
```sh
marzban restart
```

## Update
To update the template, just repeat step 1.

# Default Language
To change the default language, just refer to the end of the code in the html file and select the desired language in the select tag. Example:
```
<select id="countries" class="border text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white :focus:ring-blue-500 :focus:border blue-500">
  <option value="ru">Русский</option>
  <option value="en">English</option>
  <option value="fa">فارسی</option>
</select>
```
In this example, the main language is Russian.

# Personalization
To personalize background image and user logo, changes must be included in the html file, which is possible by searching for some values.
To search using nano, first open the file with nano with the following command:
```
nano /var/lib/marzban/templates/subscription/index.html
```
Search for the user's logo:
```
images/marzban.svg
```
Search for the background image:
```
background: url('https://4kwallpapers.com
```
After making changes, save the file and restart Marzban.

## Host Version
To use the host version, upload the sub folder to the host and change the value of BASE_URL to your panel address in the index.php file just like the following example. Remember to write http if you don't have an SSL for your panel domain.
```
const BASE_URL = "https://BaseUrl:PORT";
```

## Copyright
This template is based on <a href="https://github.com/Gozargah/Marzban">Marzban Templates<a> design.
