function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function cancut()
    local badge = false
    if has("op_hm_ex") then
        badge = (
            (has("cut_m") and has("marsh")) or
            (has("cut_v") and has("volcano")) or
            (has("cut_e") and has("earth")) or
            (has("cut_b") and has("boulder")) or
            (has("cut_t") and has("thunder")) or
            (has("cut_r") and has("rainbow")) or
            (has("cut_s") and has("soul"))
        ) or has("cascade")
    elseif has("op_hm_on") then
        badge = has("cascade")
    elseif has("op_hm_off") then
        badge = true
    end
    return ((has("cut") or has("sword")) and badge)
end

function canfly()
    local badge = false
    if has("op_hm_ex") then
        badge = (
            (has("fly_m") and has("marsh")) or
            (has("fly_v") and has("volcano")) or
            (has("fly_e") and has("earth")) or
            (has("fly_b") and has("boulder")) or
            (has("fly_c") and has("cascade")) or
            (has("fly_r") and has("rainbow")) or
            (has("fly_s") and has("soul"))
    ) or has("thunder")
    elseif has("op_hm_on") then
        badge = has("thunder")
    elseif has("op_hm_off") then
        badge = true
    end
    return ((has("fly") or has("flute")) and badge)
end

function cansurf()
    local badge = false
    if has("op_hm_ex") then
        badge = (
            (has("surf_m") and has("marsh")) or
            (has("surf_v") and has("volcano")) or
            (has("surf_e") and has("earth")) or
            (has("surf_b") and has("boulder")) or
            (has("surf_c") and has("cascade")) or
            (has("surf_t") and has("thunder")) or
            (has("surf_r") and has("rainbow"))
        ) or has("soul")
    elseif has("op_hm_on") then
        badge = has("soul")
    elseif has("op_hm_off") then
        badge = true
    end
    return ((has("surf") or has("flippers")) and badge)
end

function canstrength()
    local badge = false
    if has("op_hm_ex") then
        badge = (
            (has("strength_m") and has("marsh")) or
            (has("strength_v") and has("volcano")) or
            (has("strength_e") and has("earth")) or
            (has("strength_b") and has("boulder")) or
            (has("strength_c") and has("cascade")) or
            (has("strength_t") and has("thunder")) or
            (has("strength_s") and has("soul"))
        ) or has("rainbow")
    elseif has("op_hm_on") then
        badge = has("rainbow")
    elseif has("op_hm_off") then
        badge = true
    end
    return ((has("strength") or has("mitts")) and badge)
end

function canflash()
    local badge = false
    if has("op_hm_ex") then
        badge = (
            (has("flash_m") and has("marsh")) or
            (has("flash_v") and has("volcano")) or
            (has("flash_e") and has("earth")) or
            (has("flash_c") and has("cascade")) or
            (has("flash_t") and has("thunder")) or
            (has("flash_r") and has("rainbow")) or
            (has("flash_s") and has("soul"))
        ) or has("boulder")
    elseif has("op_hm_on") then
        badge = has("boulder")
    elseif has("op_hm_off") then
        badge = true
    end
    return ((has("flash") or has("lamp")) and badge)
end

function guard()
    return (has("tea") and has("op_tea_on")) or (has("op_tea_off") and (flylavender() or flyceladon()
    or ((flypewter() or flycerulean() or flyvermillion() or oldman()) and ((cancut() and canflash()) or (pokeflute() and boulders())))
    or (flyfuchsia() and ((pokeflute() and (boulders() or bike())) or cansurf()))
    or (canstrength() and cansurf())))
end

function guardnoflash()
    return (has("tea") and has("op_tea_on")) or (has("op_tea_off") and (flylavender() or flyceladon()
    or ((flypewter() or flycerulean() or flyvermillion() or oldman()) and (cancut() or (pokeflute() and boulders())))
    or (flyfuchsia() and ((pokeflute() and (boulders() or bike())) or cansurf()))
    or (canstrength() and cansurf())))
end

function badges()
    local amt = 0
    if has("bb") then
        amt = amt + 1
    end
    if has("cb") then
        amt = amt + 1
    end
    if has("tb") then
        amt = amt + 1
    end
    if has("rb") then
        amt = amt + 1
    end
    if has("mb") then
        amt = amt + 1
    end
    if has("sb") then
        amt = amt + 1
    end
    if has("vb") then
        amt = amt + 1
    end
    if has("eb") then
        amt = amt + 1
    end
    return amt
end

function key_items()
    local amt = 0
    if has("bike") then
        amt = amt + 1
    end
    if has("silphscope") then
        amt = amt + 1
    end
    if has("itemfinder") then
        amt = amt + 1
    end
    if has("oldrod") then
        amt = amt + 1
    end
    if has("goodrod") then
        amt = amt + 1
    end
    if has("superrod") then
        amt = amt + 1
    end
    if has("liftkey") then
        amt = amt + 1
    end
    if has("cardkey") then
        amt = amt + 1
    end
    if has("townmap") then
        amt = amt + 1
    end
    if has("coincase") then
        amt = amt + 1
    end
    if has("ticket") then
        amt = amt + 1
    end
    if has("secretkey") then
        amt = amt + 1
    end
    if has("mansionkey") then
        amt = amt + 1
    end
    if has("safaripass") then
        amt = amt + 1
    end
    if has("plantkey") then
        amt = amt + 1
    end
    if has("hideoutkey") then
        amt = amt + 1
    end
    if has("cut") then
        amt = amt + 1
    end
    if has("fly") then
        amt = amt + 1
    end
    if has("surf") then
        amt = amt + 1
    end
    if has("strength") then
        amt = amt + 1
    end
    if has("flash") then
        amt = amt + 1
    end
    if has("cardkey_progressive") then
        amt = amt + Tracker:ProviderCountForCode("cardkey_progressive")
    end
    if has ("split_cardkey") then
        amt = amt + Tracker:ProviderCountForCode("split_cardkey")
    end
    if has("stone") then
        amt = amt + Tracker:ProviderCountForCode("stone")
    end
    return amt
end

function elite4()
    local badges_required = Tracker:ProviderCountForCode("elite4_badges")
    local badges = badges()
    local key_items_required = Tracker:ProviderCountForCode("elite4_key_items")
    local key_items = key_items()
    local pokedex_required = Tracker:ProviderCountForCode("elite4_pokedex")
    local pokedex = Tracker:ProviderCountForCode("pokemon")
    return ((badges >= badges_required) and (key_items >= key_items_required) and (pokedex >= pokedex_required))
end

function victoryroad()
    local count = Tracker:ProviderCountForCode("victoryroad")
    local badges = badges()
    return (badges >= count)
end

function viridiangym()
    local count = Tracker:ProviderCountForCode("viridian")
    local badges = badges()
    return (badges >= count)
end

function ceruleancave()
    local key_item_count = Tracker:ProviderCountForCode("cerulean_items")
    local badge_count = Tracker:ProviderCountForCode("cerulean_badges")
    print(key_items() .. "items out of " .. key_item_count)
    print(badges().."out of "..badge_count)
    return (key_items() >= key_item_count) and (badges() >= badge_count)
end

function boulders()
    return canstrength() or not has("op_bldr_on")
end

function fossils()
    local count = 0
    if has("oldamber") then
        count = count + 1
    end
    if has("dome") then
        count = count + 1
    end
    if has("helix") then
        count = count + 1
    end
    local req = Tracker:ProviderCountForCode("op_fos")
    return count >= req
end

function aidedex()
    if has("op_dex_off") then
        return has("parcel")
    else return has("pokedex")
    end
end

function aide2()
    local a = Tracker:ProviderCountForCode("aide2")
    local pk = Tracker:ProviderCountForCode("pokemon")
    return (pk >= a) and aidedex()
end

function aide11()
    local a = Tracker:ProviderCountForCode("aide11")
    local pk = Tracker:ProviderCountForCode("pokemon")
    return (pk >= a) and aidedex()
end

function aide15()
    local a = Tracker:ProviderCountForCode("aide15")
    local pk = Tracker:ProviderCountForCode("pokemon")
    return (pk >= a) and aidedex()
end

function oldman()
    return has("parcel") or has("op_man_off") or cancut()
end

function pokeflute()
    return has("pokeflute")
end

function bike()
    return (has("bike") or has("op_bike_skips_on"))
end

function plant()
    return (has("plantkey") or has("op_exk_off"))
end

function hideout()
    return (has("hideoutkey") or has("op_exk_off"))
end

function mansion()
    return (has("mansionkey") or has("op_exk_off"))
end

function safari()
    return (has("safaripass") or has("op_exk_off"))
end

function pallet()
    return true
end

function viridian()
    return true
end

function flypewter()
    return canfly() and has("fly_pewter")
end

function flycerulean()
    return canfly() and has("fly_cerulean")
end

function flylavender()
    return canfly() and has("fly_lavender")
end

function flyvermillion()
    return canfly() and has("fly_vermillion")
end

function flyceladon()
    return canfly() and has("fly_celadon")
end

function flysaffron()
    return canfly() and has("fly_saffron")
end

function flyfuchsia()
    return canfly() and has("fly_fuchsia")
end

function flycinnabar()
    return canfly() and has("fly_cinnabar")
end

function flyindigo()
    return canfly() and has("fly_indigo")
end

function pewter()
    return oldman() or flypewter() or cancut()  or (cerulean_no_rt3() and cansurf())
end

function rt3()
    return (
        (pewter() and (
            has("rt3_open") 
            or (has("rt3_boulder") and has("boulder"))
            or has("rt3_brock")
            or (has("rt3_badge") and has("badge"))
            or has("rt3_gym")))
    	    or cerulean_no_rt3()
    )
end

function cerulean()
    return (
    rt3() or
    flycerulean() or
    flyvermillion() or
    (saffron() and guard())
    )
end

function cerulean_no_rt3()
    return (
    flycerulean() or
    flyvermillion() or
    (saffron() and guard())
    )
end

function vermillion()
    return cerulean()
end

function lavender()
    return (
      flylavender() or flyceladon()
      or ((flypewter() or flycerulean() or flyvermillion() or oldman()) and ((cancut() and canflash()) or guard() or (boulders() and pokeflute())))
      or (flyfuchsia() and ((pokeflute() and (boulders() or bike())) or cansurf()))
      or (canstrength() and cansurf())
      or (flysaffron() and guard())
    )
end

function lavendernoflash()
    return (
      flylavender() or flyceladon()
      or ((flypewter() or flycerulean() or flyvermillion() or oldman()) and (cancut() or guard() or (boulders() and pokeflute())))
      or (flyfuchsia() and ((pokeflute() and (boulders() or bike())) or cansurf()))
      or (canstrength() and cansurf())
      or (flysaffron() and guard())
    )
end

function celadon()
    return lavender()
end

function celadonnoflash()
    return lavendernoflash()
end

function saffron()
    return (
        flysaffron()
        or (guard() and (flypewter() or flycerulean() or flyvermillion() or flylavender() or flyceladon() or oldman()
            or ((flyfuchsia() or (canstrength() and cansurf())) and ((pokeflute() and (boulders() or bike())) or cansurf()))))
    )
end

function saffronnoflash()
    return (
        flysaffron()
        or (guardnoflash() and (flypewter() or flycerulean() or flyvermillion() or flylavender() or flyceladon() or oldman()
            or ((flyfuchsia() or (canstrength() and cansurf())) and ((pokeflute() and (boulders() or bike())) or cansurf()))))
    )
end

function fuchsia()
    return (
        flyfuchsia()
        or (cansurf() and canstrength())
        or ((flypewter() or flycerulean() or flyvermillion() or oldman())
            and (((cancut() and canflash()) or guard() or (boulders() and pokeflute())) and (((pokeflute() and (boulders() or bike())) or cansurf()))))
        or ((flyceladon() or flylavender()) and ((pokeflute() and (boulders() or bike())) or cansurf()))
        or (canstrength() and cansurf())
        or (flysaffron() and (guard() and ((pokeflute() and (boulders() or bike())) or cansurf())))
    )
end

function fuchsianoflash()
    return (
        flyfuchsia()
        or (cansurf() and canstrength())
        or ((flypewter() or flycerulean() or flyvermillion() or oldman())
            and ((cancut() or guard() or (boulders() and pokeflute())) and (((pokeflute() and (boulders() or bike())) or cansurf()))))
        or ((flyceladon() or flylavender()) and ((pokeflute() and (boulders() or bike())) or cansurf()))
        or (canstrength() and cansurf())
        or (flysaffron() and (guard() and ((pokeflute() and (boulders() or bike())) or cansurf())))
    )
end

function cinnabar()
    return (flycinnabar() or cansurf())
end
