#!/usr/bin/env perl
use Mojolicious::Lite;

my @entries = ();

get '/' => sub {
  my $c     = shift;
  my $entry = $c->param('body');
  push @entries , $entry;
  $c->stash( kakikomi => \@entries );
  $c->render('index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'BBS';
<h1>掲示板です</h1>

<form action="/" method="get">
    <input name="body" type="text">
    <input type="submit" value="GETで投稿する">
</form>
<!-- 以下の4行追加 -->
<form action="/post" method="post">
    <input name="body" type="text">
    <input type="submit" value="POSTで投稿する">
</form>

<p>
<% for my $kakiko (@{$kakikomi}){ %>
    <%= $kakiko %><br>
<% } %>
</p>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
