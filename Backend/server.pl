:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).

% Load data & reasoning from restaurants.pl
:- consult(restaurants).

% Allow all origins for the frontend
:- set_setting(http:cors, [*]).

% Register REST endpoints
:- http_handler(root(recommend), handle_recommend, [method(post), method(options)]).

% Utility to process the incoming parameter from JSON:
% 1. Convert null to '_'
% 2. Convert the string "_" to the atom '_' (for 'Any')
% 3. Convert any other Prolog string (like "spicy") to a Prolog atom (like spicy)
process_param(null, '_').
process_param("_", '_'). % Converts the Prolog string "_" to the atom '_'
process_param(ValueIn, ValueOut) :-
    ValueIn \= null,
    ValueIn \= "_",
    (   string(ValueIn) ->
        % CRITICAL FIX: Convert Prolog string (from JSON) to a Prolog atom
        atom_string(ValueOut, ValueIn) 
    ;   % If its already an atom (or anything else), pass it through
        ValueOut = ValueIn
    ).

% Handle POST and OPTIONS requests
handle_recommend(Request) :-
    cors_enable(Request, [methods([get,post,options])]),  % Enable CORS
    (   member(method(options), Request) ->  % Preflight request
        format('~n'),  % Just respond, no data needed
        true
    ;   http_read_json_dict(Request, Dict),
        
        % 1. Extract raw values 
        TasteIn   = Dict.get(taste),
        CuisineIn = Dict.get(cuisine),
        BudgetIn  = Dict.get(budget),
        CityIn    = Dict.get(city),
        
        % 2. Process all inputs to ensure they are Prolog atoms or the '_' wildcard
        process_param(TasteIn, Taste),
        process_param(CuisineIn, Cuisine),
        process_param(BudgetIn, Budget),
        process_param(CityIn, City),

        % 3. Get recommended names from the knowledge base
        recommend_partial(Taste, Cuisine, Budget, City, Names),
        
        % 4. Retrieve full details for the recommended names
        findall(
          _{ name: N, cuisine: C, taste: T, budget: B, city: L },
          ( member(N, Names),
            restaurant([N,C,T,B,L])
          ),
          ResultList
        ),
        % 5. Send results back as JSON
        reply_json_dict(_{ results: ResultList })
    ).

% Start server on port 8080
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization(server(8080)).
