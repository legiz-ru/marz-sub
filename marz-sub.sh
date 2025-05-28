#!/bin/bash

# Выбор типа установки
echo "Выберите тип установки:"
echo "1) cortez reverse proxy"
echo "2) Akiyamov xray-vps-setup"
while true; do
    read -p "Введите номер типа установки (1 или 2): " install_choice
    if [ "$install_choice" -eq 1 ]; then
        base_dir="/var/lib/marzban/templates"
        env_file="/opt/marzban/.env"
        break
    elif [ "$install_choice" -eq 2 ]; then
        base_dir="/opt/xray-vps-setup/marzban/templates"
        env_file="/opt/xray-vps-setup/marzban/.env"
        break
    else
        echo "Неверный выбор. Попробуйте снова."
    fi
done

declare -a dirs=("singbox" "v2ray" "clash" "subscription")

# Создание директорий, если они не существуют
for dir in "${dirs[@]}"; do
  if [ ! -d "$base_dir/$dir" ]; then
    mkdir -p "$base_dir/$dir"
    echo "Создана директория: $base_dir/$dir"
  fi
done

# Запрос пользовательской ссылки
read -p "Введите вашу Telegram ссылку, которая будет расположена на странице подписки (например, https://t.me/yourID/): " tg_escaped_link

# Загрузка шаблона подписки
while true; do
    echo "Выберите шаблон для скачивания:"
    echo "1) marz-sub fork by legiz (https://github.com/cortez24rus/marz-sub)"
    echo "2) marzbanify-template fork by legiz (https://github.com/legiz-ru/marzbanify-template)"
    echo "3) marzban-sub-page by streletskiy (https://github.com/streletskiy/marzban-sub-page)"
    echo "4) your web sub template https link"
    read -p "Введите номер шаблона: " choice

    if [ "$choice" -eq 1 ]; then
        shablonurl="https://github.com/cortez24rus/marz-sub/raw/main/index.html"
        wget -O "$base_dir/subscription/index.html" "$shablonurl" || echo "Ошибка загрузки index.html"
        sed -i "s#https://t.me/yourID#$tg_escaped_link#g" "$base_dir/subscription/index.html"
        break
    elif [ "$choice" -eq 2 ]; then
        shablonurl="https://github.com/legiz-ru/marzbanify-template/raw/main/index.html"
        wget -O "$base_dir/subscription/index.html" "$shablonurl" || echo "Ошибка загрузки index.html"
        sed -i "s#https://t.me/yourID#$tg_escaped_link#g" "$base_dir/subscription/index.html"
        break
    elif [ "$choice" -eq 3 ]; then
        shablonurl="https://github.com/streletskiy/marzban-sub-page/raw/main/index.html"
        wget -O "$base_dir/subscription/index.html" "$shablonurl" || echo "Ошибка загрузки index.html"
        sleep 1
        sed -i -e "s|https://t.me/gozargah_marzban|$tg_escaped_link|g" -e "s|https://github.com/Gozargah/Marzban#donation|$tg_escaped_link|g" "$base_dir/subscription/index.html"
        break
    elif [ "$choice" -eq 4 ]; then
        read -p "Введите URL для загрузки: " custom_url
        if [[ "$custom_url" =~ ^https?:// ]]; then
            shablonurl="$custom_url"
            wget -O "$base_dir/subscription/index.html" "$shablonurl" || echo "Ошибка загрузки index.html"
            break
        else
            echo "Неверный URL. Попробуйте снова."
        fi
    else
        echo "Неверный выбор. Попробуйте снова."
    fi
done

# Загрузка шаблона подписки для клиентов xray
while true; do
    echo "Выберите шаблон xray для скачивания:"
    echo "1) xray client template by legiz"
    echo "2) ru-bundle by legiz"
    echo "3) your web xray template https link"
    read -p "Введите номер шаблона (1 или 2): " choice

    if [ "$choice" -eq 1 ]; then
        xrayurl="https://github.com/cortez24rus/marz-sub/raw/main/v2ray/default.json"
        break
    elif [ "$choice" -eq 2 ]; then
        xrayurl="https://github.com/legiz-ru/mihomo-rule-sets/raw/main/other/marzban-v2ray-ru-bundle.json"
        break
    elif [ "$choice" -eq 3 ]; then
        read -p "Введите URL для загрузки: " custom_url
        if [[ "$custom_url" =~ ^https?:// ]]; then
            xrayurl="$custom_url"
            break
        else
            echo "Неверный URL. Попробуйте снова."
        fi
    else
        echo "Неверный выбор. Попробуйте снова."
    fi
done
wget -O "$base_dir/v2ray/default.json" "$xrayurl" || echo "Ошибка загрузки шаблона xray"

# Загрузка шаблона подписки для клиентов mihomo (clash meta)
while true; do
    echo "Выберите шаблон clash meta для скачивания:"
    echo "1) ru-bundle by legiz (https://github.com/legiz-ru/marz-sub)"
    echo "2) template by Skrepysh (https://github.com/Skrepysh/tools/)"
    echo "3) re-filter template (analog antizapret)"
    echo "4) your template https link"
    read -p "Введите номер шаблона: " choice

    if [ "$choice" -eq 1 ]; then
        mihomourl="https://github.com/cortez24rus/marz-sub/raw/main/clash/default.yml"
        break
    elif [ "$choice" -eq 2 ]; then
        mihomourl="https://github.com/Skrepysh/tools/raw/main/marzban-subscription-templates/clash-sub.yml"
        break
    elif [ "$choice" -eq 3 ]; then
        mihomourl="https://github.com/cortez24rus/marz-sub/raw/main/clash/refilter.yml"
        break
    elif [ "$choice" -eq 4 ]; then
        read -p "Введите URL для загрузки: " custom_url
        if [[ "$custom_url" =~ ^https?:// ]]; then
            mihomourl="$custom_url"
            break
        else
            echo "Неверный URL. Попробуйте снова."
        fi
    else
        echo "Неверный выбор. Попробуйте снова."
    fi
done
wget -O "$base_dir/clash/default.yml" "$mihomourl" || echo "Ошибка загрузки default.yml"
wget -O "$base_dir/clash/settings.yml" "https://github.com/cortez24rus/marz-sub/raw/main/clash/settings.yml" || echo "Ошибка загрузки settings.yml"

# Загрузка шаблона подписки для клиентов sing-box
while true; do
    echo "Выберите шаблон sing-box для скачивания:"
    echo "1) Secret-Sing-Box template by BLUEBL0B"
    echo "2) template by Skrepysh (https://github.com/Skrepysh/tools/)"
    echo "3) re-filter template (analog antizapret)"
    echo "4) your template https link"
    read -p "Введите номер шаблона: " choice

    if [ "$choice" -eq 1 ]; then
        wget -O "$base_dir/singbox/default.json" "https://github.com/cortez24rus/marz-sub/raw/main/singbox/ssb.json" || echo "Ошибка загрузки ssb.json"
        # Получение переменных DOMAIN и SERVER-IP
        sleep 1
        DOMAIN=$(grep "XRAY_SUBSCRIPTION_URL_PREFIX" "$env_file" | cut -d '"' -f 2 | sed 's|https://||')
        sleep 1
        SERVER_IP=$(wget -qO- https://ipinfo.io/ip)
        sleep 1
        # Обновление файла default.json (на основе клиентского шаблона secret-sing-box) в директории singbox
jq --arg domain "$DOMAIN" --arg server_ip "$SERVER_IP" '
  .dns.servers[0].client_subnet = $server_ip |
  (.dns.rules[] | select(.domain_suffix? and (.domain_suffix | length > 0)) | .domain_suffix[4]) = $domain |
  (.route.rules[] | select(.domain_suffix? and (.domain_suffix | length > 0)) | .domain_suffix[4]) = $domain |
  (.route.rules[] | select(.ip_cidr? and (.ip_cidr | length > 0)) | .ip_cidr[0]) = $server_ip
' "$base_dir/singbox/default.json" > "$base_dir/singbox/temp.json" && mv "$base_dir/singbox/temp.json" "$base_dir/singbox/default.json"
        break
    elif [ "$choice" -eq 2 ]; then
        wget -O "$base_dir/singbox/default.json" "https://github.com/Skrepysh/tools/raw/main/marzban-subscription-templates/sing-sub.json" || echo "Ошибка загрузки sing-sub.json"
        break
    elif [ "$choice" -eq 3 ]; then
        wget -O "$base_dir/singbox/default.json" "https://github.com/cortez24rus/marz-sub/raw/main/singbox/refilter.json" || echo "Ошибка загрузки refilter.json"
        break
    elif [ "$choice" -eq 4 ]; then
        read -p "Введите URL для загрузки: " custom_url
        if [[ "$custom_url" =~ ^https?:// ]]; then
            sburl="$custom_url"
            wget -O "$base_dir/singbox/default.json" "$sburl" || echo "Ошибка загрузки клиентског шаблона sing-box"
            break
        else
            echo "Неверный URL. Попробуйте снова."
        fi
    else
        echo "Неверный выбор. Попробуйте снова."
    fi
done

update_or_add() {
    local key="$1"
    local value="$2"
    local file="$3"

    # Используем awk для удаления всех предыдущих записей с этим ключом, включая закомментированные
    awk -v key="$key" -v value="$value" '
    # Удаляем строки, которые полностью совпадают с ключом (включая закомментированные)
    $1 != key && !(NF > 1 && $1 == "#" && $2 == key) {print}
    
    # Добавляем новую строку в конец файла
    END {print key " = \"" value "\""}
    ' "$file" > "$file.tmp"

    # Замена оригинального файла
    mv "$file.tmp" "$file"
}


# Обновление переменных конфигурации
update_or_add "CUSTOM_TEMPLATES_DIRECTORY" "/var/lib/marzban/templates/" "$env_file"
update_or_add "SUBSCRIPTION_PAGE_TEMPLATE" "subscription/index.html" "$env_file"
update_or_add "SINGBOX_SUBSCRIPTION_TEMPLATE" "singbox/default.json" "$env_file"
update_or_add "CLASH_SUBSCRIPTION_TEMPLATE" "clash/default.yml" "$env_file"
update_or_add "CLASH_SETTINGS_TEMPLATE" "clash/settings.yml" "$env_file"
update_or_add "V2RAY_SUBSCRIPTION_TEMPLATE" "v2ray/default.json" "$env_file"
update_or_add "SUB_SUPPORT_URL" "$tg_escaped_link" "$env_file"

echo "Обновление файла .env выполнено."

echo "Скрипт выполнен успешно."
echo "Не забудь перезапустить Marzban."
