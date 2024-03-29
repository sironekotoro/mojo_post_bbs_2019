#!/usr/bin/env perl
use Mojolicious::Lite;

my @entries = ();

get '/' => sub {
  my $c     = shift;
  $c->stash( kakikomi => \@entries );
  $c->render('index');
};

post '/post' => sub {
  my $c     = shift;
  my $entry = $c->param('body');
  push @entries , $entry;
  $c->redirect_to('/'); # 投稿を受け付けた後に、get で / に移動
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'BBS';
<h1>掲示板です</h1>

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
