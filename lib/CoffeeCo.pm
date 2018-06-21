package CoffeeCo;

use strict;
use warnings;

use Dancer2;

use CoffeeCo::DB;
use CoffeeCo::Order;
use CoffeeCo::Utils;

my $db = CoffeeCo::Utils::create_db();

get '/' => sub {


	#redirect '/new_order';
};

get '/new_order' => sub {


	template 'new_order';# => { 'title' => "aaaa" };
};

post '/new_order' => sub {

	#body_parameters->get_all( 'k' )

	my $order = CoffeeCo::Order->new(
		name => body_parameters->get( 'name' ),
		size => body_parameters->get( 'cup_size' ),
		milk => body_parameters->get( 'milk' ),
		syrup => [ body_parameters->get_all( 'syrup' ) ],
	);

	#my $db = CoffeeCo::DB->new( path => q[/tmp/] );
	
	$db->store_order( $order );
	#redirect '/orders';
};

get '/orders' => sub {

	my @orders = $db->all_orders();

	template 'orders' => { orders => \@orders };	
};


1;