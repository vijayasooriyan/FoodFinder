% =====================================
% Restaurant Recommendation Expert System
% For Major Cities in Sri Lanka
% =====================================

% -----------------------------
% Knowledge Base
% restaurant([Name, Cuisine, Taste, Budget, City]).
% Budget: low <1000, medium 1000-3000, high >3000
% -----------------------------


restaurant(['Raja Boju', sri_lankan, spicy, low, kandy]).
restaurant(['Green Cabin', dessert, sweet, medium, colombo]).
restaurant(['Pizza Hut', italian, spicy, medium, colombo]).
restaurant(['Nihonbashi', japanese, mild, high, colombo]).
restaurant(['The Empire Cafe', sri_lankan, mild, medium, kandy]).
restaurant(['Seafood Cove', seafood, savory, high, negombo]).
restaurant(['Galle Fort Cafe', italian, mild, high, galle]).
restaurant(['Jaffna Hotel', sri_lankan, spicy, medium, jaffna]).
restaurant(['Lemongrass', chinese, savory, medium, colombo]).
restaurant(['Cafe Aroma', dessert, sweet, low, galle]).
restaurant(['Spicy Hut', indian, spicy, medium, colombo]).
restaurant(['Savor Thai', thai, savory, high, colombo]).
restaurant(['Matara Beach Cafe', seafood, mild, medium, matara]).
restaurant(['Negombo Lagoon', seafood, savory, medium, negombo]).
restaurant(['Italiano', italian, mild, high, colombo]).
restaurant(['Curry Leaf', sri_lankan, spicy, medium, galle]).
restaurant(['Veggie Delight', vegetarian, mild, low, colombo]).
restaurant(['Sweet Tooth', dessert, sweet, high, kandy]).
restaurant(['King Coconut Cafe', sri_lankan, mild, low, colombo]).
restaurant(['Tandoori Nights', indian, spicy, high, colombo]).
restaurant(['Ocean Pearl', seafood, savory, high, galle]).
restaurant(['Sakura Sushi', japanese, mild, medium, colombo]).
restaurant(['Choco Heaven', dessert, sweet, medium, kandy]).
restaurant(['The Spice Garden', sri_lankan, spicy, medium, negombo]).
restaurant(['Green Leaf', vegetarian, mild, medium, kandy]).
restaurant(['Bamboo Wok', chinese, savory, low, colombo]).
restaurant(['Cafe Galle', dessert, sweet, medium, galle]).
restaurant(['Burger Hub', fast_food, savory, low, colombo]).
restaurant(['Royal Thai', thai, spicy, high, kandy]).
restaurant(['Sunset Grill', italian, mild, high, galle]).
restaurant(['Sea Breeze', seafood, savory, medium, matara]).
restaurant(['Veggie Corner', vegetarian, mild, low, negombo]).
restaurant(['Spice Junction', sri_lankan, spicy, medium, colombo]).
restaurant(['Jaffna Spice', sri_lankan, spicy, low, jaffna]).
restaurant(['Matara Cafe', dessert, sweet, low, matara]).
restaurant(['Colombo Central Cafe', fast_food, savory, medium, colombo]).
restaurant(['Golden Curry', indian, spicy, medium, galle]).
restaurant(['Cherry Blossom', japanese, mild, high, colombo]).
restaurant(['Pasta Paradise', italian, mild, medium, colombo]).
restaurant(['Sweet Escape', dessert, sweet, high, colombo]).
restaurant(['Negombo Seafood Delight', seafood, savory, high, negombo]).

% -----------------------------
% Utility Rules
% -----------------------------
% Partial matching (flexible search)
recommend_partial(Taste, Cuisine, Budget, City, Result) :-
    findall(Name,
        (restaurant([Name,C,T,B,L]),
         (Taste='_' ; T=Taste),
         (Cuisine='_' ; C=Cuisine),
         (Budget='_' ; B=Budget),
         (City='_' ; L=City)
        ),
        Temp),
    sort(Temp, Result). % remove duplicates

% -----------------------------
% Reasoning Explanation (Not used by the web API but kept for completeness)
% -----------------------------
recommend_with_reason(Taste, Cuisine, Budget, City) :-
    recommend_partial(Taste, Cuisine, Budget, City, Result),
    ( Result = [] ->
        write('Sorry, no restaurants match your preferences.'), nl
    ;
        print_reasons(Result)
    ).

% Recursive helper to print reasoning
print_reasons([]).
print_reasons([R|T]) :-
    restaurant([R, C, TASTE, B, L]),
    format('Recommended ~w because it matches your taste (~w), Cuisine (~w), budget (~w), and city (~w).~n',
           [R, TASTE, C, B, L]),
    print_reasons(T).

% -----------------------------
% Grouped Views (Not used by the web API but kept for completeness)
% -----------------------------
% Show all restaurants by city
show_by_city(City) :-
    findall([Name, Cuisine, Taste, Budget],
        restaurant([Name, Cuisine, Taste, Budget, City]),
        List),
    ( List = [] ->
        format('No restaurants found in ~w.~n', [City])
    ;
        format('Restaurants in ~w:~n', [City]),
        print_city_list(List)
    ).

print_city_list([]).
print_city_list([[N, C, T, B]|T]) :-
    format('- ~w: Cuisine: ~w, Taste: ~w, Budget: ~w~n', [N, C, T, B]),
    print_city_list(T).

% Show all restaurants by taste
show_by_taste(Taste) :-
    findall([Name, Cuisine, Budget, City],
        restaurant([Name, Cuisine, Taste, Budget, City]),
        List),
    ( List = [] ->
        format('No restaurants found with taste ~w.~n', [Taste])
    ;
        format('Restaurants with taste ~w:~n', [Taste]),
        print_taste_list(List)
    ).

print_taste_list([]).
print_taste_list([[N, C, B, L]|T]) :-
    format('- ~w: Cuisine: ~w, Budget: ~w, City: ~w~n', [N, C, B, L]),
    print_taste_list(T).

% -----------------------------
% Interactive Session (Not used by the web API but kept for completeness)
% -----------------------------
start :-
    write('Enter your taste (spicy/sweet/mild/sour/savory) or _ for any: '), read(Taste),
    write('Enter Cuisine (sri_lankan/indian/italian/chinese/japanese/dessert/vegetarian/non_vegetarian/seafood/thai) or _ for any: '), read(Cuisine),
    write('Enter budget (low/medium/high) or _ for any: '), read(Budget),
    write('Enter your city (colombo/kandy/nuwara_eliya/trincomalee/galle/jaffna/polonnaruwa/anuradhapura/negombo/matara) or _ for any: '), read(City),
    nl,
    recommend_with_reason(Taste, Cuisine, Budget, City),
    nl, write('--- Summary ---'), nl,
    (City = '_' -> true ; show_by_city(City)),
    (Taste = '_' -> true ; show_by_taste(Taste)).
