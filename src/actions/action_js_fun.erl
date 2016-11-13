% vim: sw=4 ts=4 et ft=erlang
% Nitrogen Web Framework for Erlang
% Copyright (c) 2016 Jesse Gumm
% See MIT-LICENSE for licensing information.

-module (action_js_fun).
-include("wf.hrl").
-export([
	render_action/1,
	js_fun/1,
	js_fun/2
]).

render_action(#js_fun{function=Fun0, args=Args0}) ->
	Fun = wf:to_list(Fun0),
	Args1 = [["\"",wf:js_escape(wf:to_unicode_binary(Arg)),"\""] || Arg <- Args0],
	Args = wf:join(Args1, ","),
	Code = [Fun,"(",Args,");"],
    error_logger:info_msg("Calling: ~s", [Code]),
    Code.

js_fun(Fun) ->
	js_fun(Fun, []).

js_fun(Fun, Args) when is_list(Args) ->
	wf:wire(#js_fun{function=Fun, args=Args}).
