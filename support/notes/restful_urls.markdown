## Search for Authorized values

cgi-bin/koha/admin/authorised\_values.pl?searchfield=LOST

## Look up system preferences

cgi-bin/koha/admin/preferences.pl?tab=&op=search&searchfield=OrderPdfFormat

## Finding all possible arguments

### Perl file `/tmp/greppram.pl`

    #! /usr/bin/perl -n
    
    if(/^(.*\.pl):.*(\$\w+)\s*=\s*new\s+CGI/) {
        print "grep -- '\\${2}->param' $1" . "\n";
        system "grep -- '\\${2}->param' $1 | sed 's/^/    /'"; 
    }

### Calling  `/tmp/greppram.pl`

    git grep 'new CGI' |  perl /tmp/greppram.pl | sed 's/^/    /'

## All possible arguments

    grep -- '\$input->param' acqui/addorder.pl
        my $confirm_budget_exceeding = $input->param('confirm_budget_exceeding');
            my $budget_id = $input->param('budget_id');
            my $total = $input->param('total');
                    my $basketno = $input->param('basketno');
                        values => [$input->param($_)],
                my @tags         = $input->param('tag');
                my @subfields    = $input->param('subfield');
                my @field_values = $input->param('field_value');
                my @serials      = $input->param('serial');
                my @itemid       = $input->param('itemid');
                my @ind_tag      = $input->param('ind_tag');
                my @indicator    = $input->param('indicator');
    grep -- '\$input->param' acqui/addorderiso2709.pl
        my $booksellerid  = $input->param('booksellerid');
            my @import_record_id_selected = $input->param("import_record_id");
            my @quantities = $input->param('quantity');
            my @prices = $input->param('price');
            my @budgets_id = $input->param('budget_id');
            my @discount = $input->param('discount');
            my @sort1 = $input->param('sort1');
            my @sort2 = $input->param('sort2');
                my $c_budget_id = shift( @budgets_id ) || $input->param('all_budget_id') || $budget_id;
                my $c_sort1 = shift( @sort1 ) || $input->param('all_sort1') || '';
                my $c_sort2 = shift( @sort2 ) || $input->param('all_sort2') || '';
                    my @tags         = $input->param('tag');
                    my @subfields    = $input->param('subfield');
                    my @field_values = $input->param('field_value');
                    my @serials      = $input->param('serial');
                    my @ind_tag   = $input->param('ind_tag');
                    my @indicator = $input->param('indicator');
    grep -- '\$input->param' acqui/ajax-getauthvaluedropbox.pl
        my $name = $input->param('name');
        my $category = $input->param('category');
        my $default = $input->param('default');
    grep -- '\$input->param' acqui/aqbasketuser_search.pl
        my $q = $input->param('q') || '';
        my $op = $input->param('op') || '';
    grep -- '\$query->param' acqui/basket.pl
        our $basketno     = $query->param('basketno');
        my $booksellerid = $query->param('booksellerid');
        my $op = $query->param('op');
            my $basketno = $query->param('basketno');
            my $delbiblio = $query->param('delbiblio');
            print GetBasketAsCSV($query->param('basketno'), $query);
            my $confirm = $query->param('confirm') || $confirm_pref eq '2';
                my $basketno = $query->param('basketno');
                my $booksellerid = $query->param('booksellerid');
                if ($query->param('createbasketgroup')) {
            ReopenBasket($query->param('basketno'));
            my $basketusers_ids = $query->param('basketusers_ids');
            my $branch = $query->param('branch');
    grep -- '\$input->param' acqui/basketgroup.pl
        my $op = $input->param('op') || 'display';
        my $booksellerid = $input->param('booksellerid');
            my $basketgroupid = $input->param('basketgroupid');
          my $basketno=$input->param('basketno');
          my $basketgroupid=$input->param('basketgroupid');
            my $basketgroupid = $input->param('basketgroupid');
            my $basketgroupid = $input->param('basketgroupid');
            my $basketgroupid = $input->param('basketgroupid');
            my $basketgroupid = $input->param('basketgroupid');
            my $basketgroupid   = $input->param('basketgroupid');
            my $booksellerid    = $input->param('booksellerid');
            my $redirectpath = ((defined $input->param('mode'))&& ($input->param('mode') eq 'singlebg')) ?'/cgi-bin/koha/acqui/basketgroup.pl?op=add&amp;basketgroupid='.$basketgroupid.'&amp;booksellerid='.$booksellerid : '/cgi-bin/koha/acqui/basketgroup.pl?booksellerid=' .$booksellerid.'&amp;listclosed=1';
            my @baskets           = $input->param('basket');
            my $basketgroupid     = $input->param('basketgroupid');
            my $basketgroupname   = $input->param('basketgroupname');
            my $booksellerid      = $input->param('booksellerid');
            my $billingplace      = $input->param('billingplace');
            my $deliveryplace     = $input->param('deliveryplace');
            my $freedeliveryplace = $input->param('freedeliveryplace');
            my $deliverycomment   = $input->param('deliverycomment');
            my $closedbg          = $input->param('closedbg') ? 1 : 0;
            my $redirectpath = ((defined $input->param('mode')) && ($input->param('mode') eq 'singlebg')) ?'/cgi-bin/koha/acqui/basketgroup.pl?op=add&amp;basketgroupid='.$basketgroupid.'&amp;booksellerid='.$booksellerid : '/cgi-bin/koha/acqui/basketgroup.pl?booksellerid=' . $booksellerid;
        $template->param(listclosed => ((defined $input->param('listclosed')) && ($input->param('listclosed') eq '1'))? 1:0 );
    grep -- '\$input->param' acqui/basketheader.pl
        my $booksellerid = $input->param('booksellerid');
        my $basketno = $input->param('basketno');
                    $input->param('basketname'),
                    $input->param('basketnote'),
                    $input->param('basketbooksellernote'),
                    $input->param('basketcontractnumber') || undef,
                    $input->param('basketbooksellerid'),
                    $input->param('deliveryplace'),
                    $input->param('billingplace'),
                    $input->param('basketname'),
                    $input->param('basketnote'),
                    $input->param('basketbooksellernote'),
                    $input->param('basketcontractnumber') || undef,
                    $input->param('deliveryplace'),
                    $input->param('billingplace'),
    grep -- '\$input->param' acqui/cancelorder.pl
        my $action = $input->param('action');
        my $ordernumber = $input->param('ordernumber');
        my $biblionumber = $input->param('biblionumber');
        my $referrer = $input->param('referrer') || $input->referer;
        my $del_biblio = $input->param('del_biblio') ? 1 : 0;
            my $reason = $input->param('reason');
    grep -- '\$input->param' acqui/check_budget_total.pl
        my $budget_id = $input->param('budget_id');
        my $total   = $input->param('total');
    grep -- '\$input->param' acqui/check_duplicate_barcode_ajax.pl
        my $sessid = $cookies{'CGISESSID'}->value || $input->param('CGISESSID');
        my @barcodes = $input->param('barcodes');
    grep -- '\$input->param' acqui/check_uniqueness.pl
        my @field = $input->param('field[]');
        my @value = $input->param('value[]');
    grep -- '\$input->param' acqui/currency.pl
        foreach my $param ($input->param) {
                ModCurrencies($param, $input->param($param));
    grep -- '\$input->param' acqui/finishreceive.pl
        my $biblionumber     = $input->param('biblionumber');
        my $ordernumber      = $input->param('ordernumber');
        my $origquantityrec  = $input->param('origquantityrec');
        my $quantityrec      = $input->param('quantityrec');
        my $quantity         = $input->param('quantity');
        my $unitprice        = $input->param('cost');
        my $invoiceid        = $input->param('invoiceid');
        my $booksellerid     = $input->param('booksellerid');
        my $ecost            = $input->param('ecost');
        my $rrp              = $input->param('rrp');
        my $order_internalnote = $input->param("order_internalnote");
        my $bookfund         = $input->param("bookfund");
                @received_items = $input->param('items_to_receive');
                my @tags         = $input->param('tag');
                my @subfields    = $input->param('subfield');
                my @field_values = $input->param('field_value');
                my @serials      = $input->param('serial');
                my @itemid       = $input->param('itemid');
                my @ind_tag      = $input->param('ind_tag');
                my @indicator    = $input->param('indicator');
    grep -- '\$input->param' acqui/histsearch.pl
        my $title                   = $input->param( 'title');
        my $author                  = $input->param('author');
        my $isbn                    = $input->param('isbn');
        my $name                    = $input->param( 'name' );
        my $ean                     = $input->param('ean');
        my $basket                  = $input->param( 'basket' );
        my $basketgroupname             = $input->param('basketgroupname');
        my $booksellerinvoicenumber = $input->param( 'booksellerinvoicenumber' );
        my $do_search               = $input->param('do_search') || 0;
        my $from_placed_on          = C4::Dates->new($input->param('from'));
        my $to_placed_on            = C4::Dates->new($input->param('to'));
        my $budget                  = $input->param( 'budget' );
        my $orderstatus             = $input->param( 'orderstatus' );
        my $ordernumber             = $input->param( 'ordernumber' );
        my $search_children_too     = $input->param( 'search_children_too' );
        if ( not $input->param('from') ) {
        if ( $d = $input->param('from') ) {
        if ( $d = $input->param('iso') ) {
            debug                   => $debug || $input->param('debug') || 0,
    grep -- '\$input->param' acqui/invoice-files.pl
        my $invoiceid = $input->param('invoiceid') // '';
        my $op = $input->param('op') // '';
            my $file_id = $input->param('file_id');
            if ($input->param('view') && ($ftype =~ m|^image/|i || $fname =~ /\.pdf/i)) {
                    my $filename = $input->param('uploadfile');
                            description => $input->param('description')
                $mf->DelFile( id => $input->param('file_id') );
    grep -- '\$input->param' acqui/invoice.pl
        my $invoiceid = $input->param('invoiceid');
        my $op        = $input->param('op');
            my $referer = $input->param('referer');
            my $referer = $input->param('referer');
            my $shipmentdate       = $input->param('shipmentdate');
            my $billingdate        = $input->param('billingdate');
            my $shipmentcost       = $input->param('shipmentcost');
            my $shipment_budget_id = $input->param('shipment_budget_id');
            if ($input->param('reopen')) {
            } elsif ($input->param('close')) {
            } elsif ($input->param('merge')) {
                my @sources = $input->param('merge');
            my $referer = $input->param('referer') || 'invoices.pl';
    grep -- '\$input->param' acqui/lateorders-export.pl
        my @ordernumbers = $input->param('ordernumber');
    grep -- '\$input->param' acqui/lateorders.pl
        my $booksellerid = $input->param('booksellerid') || undef; # we don't want "" or 0
        my $delay        = $input->param('delay') // 0;
        my $estimateddeliverydatefrom = $input->param('estimateddeliverydatefrom');
        my $estimateddeliverydateto   = $input->param('estimateddeliverydateto');
        my $branch     = $input->param('branch');
        my $op         = $input->param('op');
            my @ordernums = $input->param("ordernumber");# FIXME: Fallback values?
                $err = SendAlerts( 'claimacquisition', \@ordernums, $input->param("letter_code") );    # FIXME: Fallback value?
    grep -- '\$input->param' acqui/modordernotes.pl
        my $op = $input->param('op');
        my $ordernumber = $input->param('ordernumber');
        my $referrer = $input->param('referrer') || $input->referer();
        my $type = $input->param('type');
            my $ordernotes = $input->param('ordernotes');
    grep -- '\$input->param' acqui/neworderempty.pl
        my $booksellerid    = $input->param('booksellerid');    # FIXME: else ERROR!
        my $budget_id       = $input->param('budget_id') || 0;
        my $title           = $input->param('title');
        my $author          = $input->param('author');
        my $publicationyear = $input->param('publicationyear');
        my $ordernumber          = $input->param('ordernumber') || '';
        our $biblionumber    = $input->param('biblionumber');
        our $basketno        = $input->param('basketno');
        my $suggestionid    = $input->param('suggestionid');
        my $close           = $input->param('close');
        my $uncertainprice  = $input->param('uncertainprice');
        my $import_batch_id = $input->param('import_batch_id'); # if this is filled, we come from a staged file, and we will return here after saving the order !
        my $subscriptionid  = $input->param('subscriptionid');
            if($biblionumber && !$input->param('use_external_source')) {
                $basket = GetBasket( $input->param('basketno') );
        my $quantity = $input->param('rr_quantity_to_order') ?
              $input->param('rr_quantity_to_order') :
    grep -- '\$query->param' acqui/newordersubscription.pl
        my $title        = $query->param('title_filter');
        my $ISSN         = $query->param('ISSN_filter');
        my $EAN          = $query->param('EAN_filter');
        my $publisher    = $query->param('publisher_filter');
        my $supplier     = $query->param('supplier_filter');
        my $branch       = $query->param('branch_filter');
        my $routing      = $query->param('routing') || C4::Context->preference("RoutingSerials");
        my $searched     = $query->param('searched');
        my $biblionumber = $query->param('biblionumber');
        my $basketno     = $query->param('basketno');
        my $booksellerid = $query->param('booksellerid');
    grep -- '\$input->param' acqui/newordersuggestion.pl
        my $basketno        = $input->param('basketno');
        my $booksellerid      = $input->param('booksellerid');
        my $author          = $input->param('author');
        my $title           = $input->param('title');
        my $publishercode   = $input->param('publishercode');
        my $op              = $input->param('op');
        my $suggestionid    = $input->param('suggestionid');
        my $duplicateNumber = $input->param('duplicateNumber');
        my $uncertainprice = $input->param('uncertainprice');
    grep -- '\$input->param' acqui/ordered.pl
        my $fund_id = $input->param('fund');
        my $fund_code = $input->param('fund_code');
    grep -- '\$input->param' acqui/orderreceive.pl
        my $invoiceid    = $input->param('invoiceid');
        my $ordernumber  = $input->param('ordernumber');
        my $op = $input->param('op');
    grep -- '\$input->param' acqui/parcel.pl
        my $sticky_filters = $input->param('sticky_filters') || 0;
        my $op = $input->param('op') // '';
            my $ordernumber = $input->param('ordernumber');
        my $invoiceid = $input->param('invoiceid');
                    $search   = $input->param('summaryfilter') || '';
                    $ean      = $input->param('eanfilter') || '';
                    $basketname = $input->param('basketfilter') || '';
                    $orderno  = $input->param('orderfilter') || '';
                    $basketgroupname = $input->param('basketgroupnamefilter') || '';
    grep -- '\$input->param' acqui/spent.pl
        my $bookfund = $input->param('fund');
        my $fund_code = $input->param('fund_code');
    grep -- '\$input->param' acqui/transferorder.pl
        my $bookselleridfrom    = $input->param('bookselleridfrom');
        my $ordernumber     = $input->param('ordernumber');
        my $bookselleridto  = $input->param('bookselleridto');
        my $basketno        = $input->param('basketno');
        my $op              = $input->param('op');
        my $query           = $input->param('query');
    grep -- '\$input->param' acqui/uncertainprice.pl
        my $booksellerid = $input->param('booksellerid');
        my $basketno     = $input->param('basketno');
        my $op = $input->param('op');
        my $owner = $input->param('owner') || 0 ; # flag to see only "my" orders, or everyone orders
                $order->{'listprice'} = $input->param('price'.$ordernumber);
                $order->{'ecost'}= $input->param('price'.$ordernumber) - (($input->param('price'.$ordernumber) /100) * $bookseller->{'discount'});
                $order->{'rrp'} = $input->param('price'.$ordernumber);
                $order->{'quantity'}=$input->param('qty'.$ordernumber);
                $order->{'uncertainprice'}=$input->param('uncertainprice'.$ordernumber);
    grep -- '\$input->param' acqui/updatesupplier.pl
        my $booksellerid=$input->param('booksellerid');
        $data{'name'}=$input->param('company');
        $data{'postal'}=$input->param('company_postal');
        my $address=$input->param('physical');
        $data{'phone'}=$input->param('company_phone');
        $data{'accountnumber'}=$input->param('accountnumber');
        $data{'fax'}=$input->param('company_fax');
        $data{'url'}=$input->param('website');
        $data{'notes'}=$input->param('notes');
        $data{'active'}=$input->param('status');
        $data{'listprice'}=$input->param('list_currency');
        $data{'invoiceprice'}=$input->param('invoice_currency');
        $data{'gstreg'}=$input->param('gst');
        $data{'listincgst'}=$input->param('list_gst');
        $data{'invoiceincgst'}=$input->param('invoice_gst');
        $data{'gstrate'} = $input->param('gstrate');
        $data{'discount'} = $input->param('discount');
        $data{deliverytime} = $input->param('deliverytime');
        $data{'active'}=$input->param('status');
            $contact_info{$_} = [ $input->param('contact_' . $_) ];
    grep -- '\$input->param' acqui/z3950_search.pl
        my $biblionumber    = $input->param('biblionumber')||0;
        my $frameworkcode   = $input->param('frameworkcode')||'';
        my $title           = $input->param('title');
        my $author          = $input->param('author');
        my $isbn            = $input->param('isbn');
        my $issn            = $input->param('issn');
        my $lccn            = $input->param('lccn');
        my $lccall          = $input->param('lccall');
        my $subject         = $input->param('subject');
        my $dewey           = $input->param('dewey');
        my $controlnumber   = $input->param('controlnumber');
        my $op              = $input->param('op')||'';
        my $booksellerid    = $input->param('booksellerid');
        my $basketno        = $input->param('basketno');
        my $page            = $input->param('current_page') || 1;
        $page               = $input->param('goto_page') if $input->param('changepage_goto');
        my @id = $input->param('id');
    grep -- '\$input->param' admin/aqbudget_user_search.pl
        my $type = $input->param('type');
        my $member  = $input->param('member') // '';
    grep -- '\$input->param' admin/aqbudgetperiods.pl
        my $searchfield          = $input->param('searchfield') // '';
        my $budget_period_id     = $input->param('budget_period_id');
        my $op                   = $input->param('op')||"else";
        #my $sort1_authcat = $input->param('sort1_authcat');
        #my $sort2_authcat = $input->param('sort2_authcat');
        my $budget_period_hashref = { map { join(' ',@columns) =~ /$_/ ? ( $_ => $input->param($_) )  : () } keys( %{$input->Vars()} ) } ;
        $budget_period_hashref->{budget_period_startdate} = dt_from_string( $input->param('budget_period_startdate') );
        $budget_period_hashref->{budget_period_enddate}   = dt_from_string( $input->param('budget_period_enddate') );
            my $budget_period_startdate = dt_from_string $input->param('budget_period_startdate');
            my $budget_period_enddate   = dt_from_string $input->param('budget_period_enddate');
            my $budget_period_description = $input->param('budget_period_description');
            my $mark_original_budget_as_inactive = $input->param('mark_original_budget_as_inactive');
            my $reset_all_budgets = $input->param('reset_all_budgets');
            my $to_budget_period_id    = $input->param('to_budget_period_id');
            my $move_remaining_unspent = $input->param('move_remaining_unspent');
        my $activepage = $input->param('apage') || 1;
        my $inactivepage = $input->param('ipage') || 1;
        my $tab = $input->param('tab') ? $input->param('tab') - 1 : 0;
    grep -- '\$input->param' admin/aqbudgets.pl
        my $op = $input->param('op') || 'list';
        my $show_mine = $input->param('show_mine') // 0;
        my $budget_hash = { map { join(' ',@columns) =~ /$_/ ? ( $_ => $input->param($_) )  : () } keys( %{$input->Vars()}) } ;
        my $budget_id                 = $input->param('budget_id');
        my $budget_period_id          = $input->param('budget_period_id');
        my $budget_permission         = $input->param('budget_permission');
        my $budget_users_ids          = $input->param('budget_users_ids');
        my $filter_budgetbranch       = $input->param('filter_budgetbranch') // '';
        my $filter_budgetname         = $input->param('filter_budgetname');
                $budget_parent_id = $input->param('budget_parent_id');
            my $set_owner_to_children = $input->param('set_owner_to_children');
    grep -- '\$input->param' admin/aqcontract.pl
        my $contractnumber = $input->param('contractnumber');
        my $booksellerid   = $input->param('booksellerid');
        my $op             = $input->param('op') || 'list';
            my $is_a_modif = $input->param("is_a_modif");
                    contractstartdate   => format_date_in_iso( $input->param('contractstartdate') ),
                    contractenddate     => format_date_in_iso( $input->param('contractenddate') ),
                    contractname        => $input->param('contractname'),
                    contractdescription => $input->param('contractdescription'),
                    booksellerid        => $input->param('booksellerid'),
                    contractnumber      => $input->param('contractnumber'),
                    contractname        => $input->param('contractname'),
                    contractdescription => $input->param('contractdescription'),
                    booksellerid        => $input->param('booksellerid'),
                    contractstartdate   => format_date_in_iso( $input->param('contractstartdate') ),
                    contractenddate     => format_date_in_iso( $input->param('contractenddate') ),
    grep -- '\$input->param' admin/aqplan.pl
        my $budget_period_id = $input->param('budget_period_id');
        my $authcat      = $input->param('authcat');
        my $show_active  = $input->param('show_active');
        my $show_actual  = $input->param('show_actual');
        my $show_percent = $input->param('show_percent');
        my $output       = $input->param("output");
        my $basename     = $input->param("basename");
        my $del          = $input->param("sep");
        my $show_mine       = $input->param('show_mine') ;
        my @hide_cols      = $input->param('hide_cols');
        my $budget_id = $input->param('budget_id');
        my $op        = $input->param("op");
        my @names = $input->param();
                    my $estimated_amount = $input->param("$cell_name");
    grep -- '\$input->param' admin/auth_subfields_structure.pl
        my $tagfield     = $input->param('tagfield');
        my $tagsubfield  = $input->param('tagsubfield');
        my $authtypecode = $input->param('authtypecode');
        my $offset       = $input->param('offset');
        my $op           = $input->param('op') || '';
            my $more_subfields = $input->param("more_subfields")+1;
            $template->param(tagfield => "$input->param('tagfield')");
            my @tagsubfield = $input->param('tagsubfield');
            my @liblibrarian    = $input->param('liblibrarian');
            my @libopac     = $input->param('libopac');
            my @kohafield       = ''.$input->param('kohafield');
            my @tab             = $input->param('tab');
            my @seealso     = $input->param('seealso');
            my @ohidden     = $input->param('ohidden');
            #my @ihidden        = $input->param('ihidden');
            #my @ehidden        = $input->param('ehidden');
            my @authorised_values   = $input->param('authorised_value');
            my $authtypecode    = $input->param('authtypecode');
            my @frameworkcodes  = $input->param('frameworkcode');
            my @value_builder   =$input->param('value_builder');
            my @defaultvalue = $input->param('defaultvalue');
                my $tagfield            =$input->param('tagfield');
                my $repeatable      =$input->param("repeatable$i")?1:0;
                my $mandatory       =$input->param("mandatory$i")?1:0;
                my $isurl = $input->param("isurl$i")?1:0;
    grep -- '\$input->param' admin/auth_tag_structure.pl
        my $authtypecode         = $input->param('authtypecode')         || '';    # set to select framework
        my $existingauthtypecode = $input->param('existingauthtypecode') || '';    # set when we have to create a new framework (in authtype) by copying an old one (in existingauthtype)
        my $searchfield = $input->param('searchfield') || 0;
        my $offset      = $input->param('offset') || 0;
        my $op          = $input->param('op')     || '';
            my $tagfield         = $input->param('tagfield');
            my $liblibrarian     = $input->param('liblibrarian');
            my $libopac          = $input->param('libopac');
            my $repeatable       = $input->param('repeatable') ? 1 : 0;
            my $mandatory        = $input->param('mandatory')  ? 1 : 0;
            my $authorised_value = $input->param('authorised_value');
                if ($input->param('modif')) {
            my $tagfield = $input->param('tagfield');
    grep -- '\$input->param' admin/authorised_values.pl
        my $id          = $input->param('id');
        my $op          = $input->param('op')     || '';
        our $offset      = $input->param('offset') || 0;
        our $searchfield = $input->param('searchfield');
                $data->{'category'} = $input->param('category');
            my $new_authorised_value = $input->param('authorised_value');
            my $new_category = $input->param('category');
            my $imageurl     = $input->param( 'imageurl' ) || '';
            my @branches = $input->param('branches');
                    my $lib = $input->param('lib');
                    my $lib_opac = $input->param('lib_opac');
                    my $lib = $input->param('lib');
                    my $lib_opac = $input->param('lib_opac');
                    my $category = $input->param('category');
            $id = $input->param('id') unless $id;
            my $id = $input->param('id');
    grep -- '\$input->param' admin/authtypes.pl
        my $searchfield  = $input->param('authtypecode');  # FIXME: Auth Type search not really implemented
        my $authtypecode = $input->param('authtypecode');
        my $offset       = $input->param('offset') || 0;
        my $op           = $input->param('op')     || '';
            my $sth = $input->param('modif') ? 
            $sth->execute($input->param('authtypetext'),$input->param('auth_tag_to_report'),$input->param('summary'),$input->param('authtypecode'));
            $sth->execute(uc $input->param('authtypecode'));
    grep -- '\$input->param' admin/biblio_framework.pl
        my $frameworkcode = $input->param('frameworkcode') || '';
        my $offset        = $input->param('offset') || 0;
        my $op            = $input->param('op') || '';
            if ( $input->param('frameworktext') and $frameworkcode ) {
                if ($input->param('modif')) {
                    $sth->execute( $input->param('frameworktext'), $frameworkcode );
                    $sth->execute( $frameworkcode, $input->param('frameworktext') );
    grep -- '\$input->param' admin/branch_transfer_limits.pl
        if((!defined($input->param('branchcode'))) & mybranch() ne '')
            $branchcode = $input->param('branchcode');
        if ( $input->param('updateLimits') ) {
                    my $isSet = not $input->param( $code . "_" . $toBranch);
    grep -- '\$input->param' admin/branches.pl
        my $branchcode   = $input->param('branchcode');
        my $branchname   = $input->param('branchname');
        my $categorycode = $input->param('categorycode');
        my $op           = $input->param('op') || '';
            elsif ($input->param('add')){
            if (CheckCategoryUnique($input->param('categorycode'))){
    grep -- '\$input->param' admin/categorie.pl
        my $searchfield   = $input->param('description');
        my $categorycode  = $input->param('categorycode');
        my $op            = $input->param('op') // '';
        my $block_expired = $input->param("block_expired");
            my $is_a_modif = $input->param("is_a_modif");
            if ( $input->param('enrolmentperioddate') ) {
                $input->param(
                        $input->param('enrolmentperioddate')
                    map { $input->param($_) } (
                my @branches = $input->param("branches");
                    $sth->execute( $input->param("categorycode") );
                        $sth->bind_param( 1, $input->param("categorycode") );
                    map { $input->param($_) } (
                    { categorycode => $input->param('categorycode') }, $template );
            my $categorycode = uc( $input->param('categorycode') );
    grep -- '\$input->param' admin/check_budget_parent.pl
        my $budget_id     = $input->param('budget_id');
        my $new_parent_id = $input->param('new_parent');
    grep -- '\$input->param' admin/check_parent_total.pl
        my $total     = $input->param('total');
        my $budget_id = $input->param('budget_id');
        my $parent_id = $input->param('parent_id');
        my $period_id = $input->param('period_id');
    grep -- '\$input->param' admin/cities.pl
        my $searchfield = $input->param('city_name');
        my $cityid      = $input->param('cityid');
        my $op          = $input->param('op') || '';
            if ($input->param('cityid') ){
                $sth->execute($input->param('city_name'),$input->param('city_state'),$input->param('city_zipcode'),$input->param('city_country'),$input->param('cityid'));
                $sth->execute($input->param('city_name'),$input->param('city_state'),$input->param('city_zipcode'),$input->param('city_country'));
    grep -- '\$input->param' admin/classsources.pl
        my $op          = $input->param('op') || '';
        my $source_code = $input->param('class_source');
        my $rule_code   = $input->param('sort_rule');
                             $input->param('description'),
                             $input->param('used') eq "used" ? 1 : 0,
                             $input->param('description'),
                             $input->param('used') eq "used" ? 1 : 0,
                                $input->param('description'),
                                $input->param('sort_routine'));
                                 $input->param('description'),
                                 $input->param('sort_routine'));
    grep -- '\$input->param' admin/clone-rules.pl
        my $frombranch = $input->param("frombranch");
        my $tobranch   = $input->param("tobranch");
    grep -- '\$input->param' admin/columns_settings.pl
        my $action = $input->param('action') // 'list';
            my $module = $input->param('module');
            my @columnids = $input->param("columnid");
                my $is_hidden = $input->param( $columnid . '_hidden' ) // 0;
                  $input->param( $columnid . '_cannot_be_toggled' ) // 0;
                panel   => ( $input->param('panel') || 0 ),
    grep -- '\$query->param' admin/fieldmapping.pl
        my $framework = $query->param('framework') || "";
        my $field         = $query->param('fieldname');
        my $fieldcode     = $query->param('marcfield');
        my $subfieldcode  = $query->param('marcsubfield');
        my $op            = $query->param('op') || q{};
        my $id            = $query->param('id');
    grep -- '\$input->param' admin/import_export_framework.pl
        my $frameworkcode = $input->param('frameworkcode') || '';
        my $action = $input->param('action') || 'export';
            my $format = $input->param('type_export_' . $frameworkcode);
            my $filename = $input->param($fieldname);
                    my $tmpfilename = $input->tmpFileName($input->param($fieldname));
    grep -- '\$input->param' admin/item_circulation_alerts.pl
                    debug           => defined($input->param('debug')),
            my $branch   = $input->param('branch') || '*';
            my $id = $input->param('id');
            my $branch = $input->param('branch');
            my $action = $input->param('action') || 'show';
    grep -- '\$cgi->param' admin/items_search_field.pl
        my $op = $cgi->param('op') || '';
        my $name = $cgi->param('name');
    grep -- '\$cgi->param' admin/items_search_fields.pl
        my $op = $cgi->param('op') || '';
            my $name = $cgi->param('name');
            my $updated = $cgi->param('updated');
    grep -- '\$input->param' admin/itemtypes.pl
        my $searchfield = $input->param('description');
        my $itemtype    = $input->param('itemtype');
        my $op          = $input->param('op');
        my $sip_media_type = $input->param('sip_media_type');
                    $input->param('description'),
                    $input->param('rentalcharge'),
                    ( $input->param('notforloan') ? 1 : 0 ),
                        $input->param('image') eq 'removeImage' ? '' : (
                              $input->param('image') eq 'remoteImage'
                            ? $input->param('remoteImage')
                            : $input->param('image') . ""
                    $input->param('summary'),
                    $input->param('checkinmsg'),
                    $input->param('checkinmsgtype'),
                    $input->param('itemtype')
                my $image = $input->param('image');
                    $input->param('itemtype'),
                    $input->param('description'),
                    $input->param('rentalcharge'),
                    $input->param('notforloan') ? 1 : 0,
                    $image eq 'remoteImage' ? $input->param('remoteImage') :
                    $input->param('summary'),
                    $input->param('checkinmsg'),
                    $input->param('checkinmsgtype'),
            my $itemtype = uc( $input->param('itemtype') );
    grep -- '\$input->param' admin/koha2marclinks.pl
        my $tablename   = $input->param('tablename');
        my $kohafield   = $input->param('kohafield');
        my $op          = $input->param('op');
            my @temp = split / /, $input->param('marc');
    grep -- '\$input->param' admin/marc_subfields_structure.pl
        my $tagfield      = $input->param('tagfield');
        my $tagsubfield   = $input->param('tagsubfield');
        my $frameworkcode = $input->param('frameworkcode');
        my $offset        = $input->param('offset');
        my $op       = $input->param('op');
            my $more_subfields = $input->param("more_subfields") + 1;
            $template->param( tagfield => "$input->param('tagfield')" );
            my @tagsubfield       = $input->param('tagsubfield');
            my @liblibrarian      = $input->param('liblibrarian');
            my @libopac           = $input->param('libopac');
            my @kohafield         = $input->param('kohafield');
            my @tab               = $input->param('tab');
            my @seealso           = $input->param('seealso');
            my @hidden            = $input->param('hidden');
            my @authorised_values = $input->param('authorised_value');
            my @authtypecodes     = $input->param('authtypecode');
            my @value_builder     = $input->param('value_builder');
            my @link              = $input->param('link');
            my @defaultvalue      = $input->param('defaultvalue');
            my @maxlength         = $input->param('maxlength');
                my $tagfield    = $input->param('tagfield');
                my $repeatable       = $input->param("repeatable$i") ? 1 : 0;
                my $mandatory        = $input->param("mandatory$i") ? 1 : 0;
                my $isurl  = $input->param("isurl$i") ? 1 : 0;
    grep -- '\$input->param' admin/marctagstructure.pl
        my $frameworkcode         = $input->param('frameworkcode')         || ''; # set to select framework
        my $existingframeworkcode = $input->param('existingframeworkcode') || '';
        my $searchfield           = $input->param('searchfield') || 0;
        my $offset    = $input->param('offset') || 0;
        my $op        = $input->param('op')     || '';
        my $dspchoice = $input->param('select_display');
            my $tagfield         = $input->param('tagfield');
            my $liblibrarian     = $input->param('liblibrarian');
            my $libopac          = $input->param('libopac');
            my $repeatable       = $input->param('repeatable') ? 1 : 0;
            my $mandatory        = $input->param('mandatory')  ? 1 : 0;
            my $authorised_value = $input->param('authorised_value');
                if ($input->param('modif')) {
    grep -- '\$input->param' admin/matching-rules.pl
        my $op = $input->param('op') || '';
        my $matcher_id = $input->param("matcher_id");
            my $record_type = $input->param('record_type') || 'biblio';
            $matcher->code($input->param('code'));
            $matcher->description($input->param('description'));
            $matcher->threshold($input->param('threshold'));
            my @mp_nums = sort map { /^mp_(\d+)_search_index/ ? int($1): () } $input->param;
                my $index = $input->param("mp_${mp_num}_search_index");
                my $score = $input->param("mp_${mp_num}_score");
                my @comp_nums = sort map { /^mp_${mp_num}_c_(\d+)_tag/ ? int($1): () } $input->param;
                    $component->{'tag'} = $input->param("mp_${mp_num}_c_${comp_num}_tag");
                    $component->{'subfields'} = $input->param("mp_${mp_num}_c_${comp_num}_subfields");
                    $component->{'offset'} = $input->param("mp_${mp_num}_c_${comp_num}_offset");
                    $component->{'length'} = $input->param("mp_${mp_num}_c_${comp_num}_length");
                    my @norm_nums = sort map { /^mp_${mp_num}_c_${comp_num}_n_(\d+)_norm/ ? int($1): () } $input->param;
                        push @{ $component->{'norms'} }, $input->param("mp_${mp_num}_c_${comp_num}_n_${norm_num}_norm");
            my @mc_nums = sort map { /^mc_(\d+)_id/ ? int($1): () } $input->param;
                my @src_comp_nums = sort map { /^mc_${mc_num}_src_c_(\d+)_tag/ ? int($1): () } $input->param;
                    $component->{'tag'} = $input->param("mc_${mc_num}_src_c_${comp_num}_tag");
                    $component->{'subfields'} = $input->param("mc_${mc_num}_src_c_${comp_num}_subfields");
                    $component->{'offset'} = $input->param("mc_${mc_num}_src_c_${comp_num}_offset");
                    $component->{'length'} = $input->param("mc_${mc_num}_src_c_${comp_num}_length");
                    my @norm_nums = sort map { /^mc_${mc_num}_src_c_${comp_num}_n_(\d+)_norm/ ? int($1): () } $input->param;
                        push @{ $component->{'norms'} }, $input->param("mc_${mc_num}_src_c_${comp_num}_n_${norm_num}_norm");
                my @tgt_comp_nums = sort map { /^mc_${mc_num}_tgt_c_(\d+)_tag/ ? int($1): () } $input->param;
                    $component->{'tag'} = $input->param("mc_${mc_num}_tgt_c_${comp_num}_tag");
                    $component->{'subfields'} = $input->param("mc_${mc_num}_tgt_c_${comp_num}_subfields");
                    $component->{'offset'} = $input->param("mc_${mc_num}_tgt_c_${comp_num}_offset");
                    $component->{'length'} = $input->param("mc_${mc_num}_tgt_c_${comp_num}_length");
                    my @norm_nums = sort map { /^mc_${mc_num}_tgt_c_${comp_num}_n_(\d+)_norm/ ? int($1): () } $input->param;
                        push @{ $component->{'norms'} }, $input->param("mc_${mc_num}_tgt_c_${comp_num}_n_${norm_num}_norm");
    grep -- '\$input->param' admin/oai_set_mappings.pl
        my $id = $input->param('id');
        my $op = $input->param('op');
            my @marcfields = $input->param('marcfield');
            my @marcsubfields = $input->param('marcsubfield');
            my @operators = $input->param('operator');
            my @marcvalues = $input->param('marcvalue');
    grep -- '\$input->param' admin/oai_sets.pl
        my $op = $input->param('op');
            my $spec = $input->param('spec');
            my $name = $input->param('name');
            my @descriptions = $input->param('description');
            my $id = $input->param('id');
            my $id = $input->param('id');
            my $spec = $input->param('spec');
            my $name = $input->param('name');
            my @descriptions = $input->param('description');
            my $id = $input->param('id');
    grep -- '\$input->param' admin/patron-attr-types.pl
        my $op = $input->param('op') || '';
        my $code = $input->param("code");
            $template->param(description => $input->param('description'));
            if ($input->param('repeatable')) {
            if ($input->param('unique_id')) {
            if ($input->param('password_allowed')) {
            if ($input->param('opac_display')) {
            if ($input->param('staff_searchable')) {
            if ($input->param('display_checkout')) {
            $template->param( category_code => $input->param('category_code') );
            $template->param( class => $input->param('class') );
            authorised_value_category_list($template, $input->param('authorised_value_category'));
            my $description = $input->param('description');
                my $repeatable = $input->param('repeatable');
                my $unique_id = $input->param('unique_id');
            my $opac_display = $input->param('opac_display');
            my $staff_searchable = $input->param('staff_searchable');
            my $authorised_value_category = $input->param('authorised_value_category');
            my $password_allowed = $input->param('password_allowed');
            my $display_checkout = $input->param('display_checkout');
            $attr_type->category_code($input->param('category_code'));
            $attr_type->class($input->param('class'));
            my @branches = $input->param('branches');
    grep -- '\$input->param' admin/preferences.pl
        my $op = $input->param( 'op' ) || '';
        my $tab = $input->param( 'tab' );
                foreach my $param ( $input->param() ) {
                    my $value = join( ',', $input->param( $param ) );
            my $searchfield = $input->param( 'searchfield' );
    grep -- '\$input->param' admin/printers.pl
        my $searchfield=$input->param('searchfield');
        #my $branchcode=$input->param('branchcode');
        my $offset=$input->param('offset') || 0;
        my $op = $input->param('op');
            if ($input->param('add')){
                $sth->execute($input->param('printername'),$input->param('printqueue'),$input->param('printtype'));
                $sth->execute($input->param('printqueue'),$input->param('printtype'),$input->param('printername'));
    grep -- '\$input->param' admin/sru_modmapping.pl
        my $mapstr = $input->param('mapping')//'';
    grep -- '\$input->param' admin/stopwords.pl
        my $searchfield = $input->param('searchfield');
        my $offset      = $input->param('offset') || 0;
        my $op = $input->param('op') || '';
            my @tab = split / |,/, $input->param('word');
    grep -- '\$input->param' admin/systempreferences.pl
        my $searchfield = $input->param('searchfield') || '';
        my $Tvalue      = $input->param('Tvalue');
        my $offset      = $input->param('offset') || 0;
        my $op = $input->param('op') || '';
            foreach ( $input->param ) {
            if ( my $currentorder = $input->param('currentorder') ) {
                foreach my $param ( $input->param ) {
            $sth->execute( $input->param('variable') );
                    $sth->execute( $value, $input->param('explanation'), $input->param('variable'), $input->param('preftype'), $input->param('prefoptions') );
                    logaction( 'SYSTEMPREFERENCE', 'MODIFY', undef, $input->param('variable') . " | " . $value );
                    $sth->execute( $input->param('variable'), $input->param('value'), $input->param('explanation'), $input->param('preftype'), $input->param('prefoptions') );
                    logaction( 'SYSTEMPREFERENCE', 'ADD', undef, $input->param('variable') . " | " . $input->param('value') );
            $sth->execute( $input->param('variable') );
            if ( $input->param('preftype') eq 'Upload' ) {
                    $sth->execute( $value, $input->param('explanation'), $input->param('preftype'), $input->param('prefoptions'), $input->param('variable') );
                    logaction( 'SYSTEMPREFERENCE', 'MODIFY', undef, $input->param('variable') . " | " . $value );
                    $sth->execute( $input->param('variable'), $value, $input->param('explanation'), $input->param('preftype'), $input->param('prefoptions') );
                    logaction( 'SYSTEMPREFERENCE', 'ADD', undef, $input->param('variable') . " | " . $value );
            my $tab = $input->param('tab')||'local_use';
    grep -- '\$input->param' admin/transport-cost-matrix.pl
        my $update = $input->param('op') eq 'set-cost-matrix';
                    my $value = $from_to_input_def{value} = $input->param($input_name);
                    if ( $input->param($disable_name) ) {
    grep -- '\$input->param' admin/z3950servers.pl
        my $op = $input->param('op') || 'list';
        my $id = $input->param('id') || 0;
        my $type = $input->param('type') || '';
            $searchfield = $input->param('searchfield') || '';
            return { map { ( $_ => $input->param($_)//'' ) } @$fieldref };
    grep -- '\$query->param' authorities/auth_finder.pl
        my $op           = $query->param('op') || '';
        my $authtypecode = $query->param('authtypecode') || '';
        my $index        = $query->param('index') || '';
        my $tagid        = $query->param('tagid') || '';
        my $source       = $query->param('source') || '';
        my $relationship = $query->param('relationship') || '';
            my @marclist  = $query->param('marclist');
            my @and_or    = $query->param('and_or');
            my @excluding = $query->param('excluding');
            my @operator  = $query->param('operator');
                $query->param('value_mainstr') || undef,
                $query->param('value_main')    || undef,
                $query->param('value_any')     || undef,
                $query->param('value_match')   || undef
            my $orderby        = $query->param('orderby')        || '';
            my $startfrom      = $query->param('startfrom')      || 0;
            my $resultsperpage = $query->param('resultsperpage') || 20;
            my @marclist_ini = $query->param('marclist');
              { term => "value_mainstr", val => $query->param('value_mainstr') || "" };
              { term => "value_main", val => $query->param('value_main') || "" };
              { term => "value_any", val => $query->param('value_any') || "" };
              { term => "value_match", val => $query->param('value_match') || "" };
            my $resultstring = $query->param('result') || '';
            value_mainstr => $query->param('value_mainstr') || '',
            value_main    => $query->param('value_main') || '',
            value_any     => $query->param('value_any') || '',
            value_match   => $query->param('value_match') || '',
    grep -- '\$query->param' authorities/authorities-home.pl
        my $op           = $query->param('op')           || '';
        my $authtypecode = $query->param('authtypecode') || '';
        my $authid       = $query->param('authid')       || '';
            if ( $query->param('operator') ) {
            my $marclist  = $query->param('marclist')  || '';
            my $and_or    = $query->param('and_or')    || '';
            my $excluding = $query->param('excluding') || '';
            my $operator  = $query->param('operator')  || '';
            my $orderby   = $query->param('orderby')   || '';
            my $value     = $query->param('value')     || '';
            my $startfrom      = $query->param('startfrom')      || 1;
            my $resultsperpage = $query->param('resultsperpage') || 20;
    grep -- '\$input->param' authorities/authorities.pl
        my $z3950 = $input->param('z3950');
        my $error = $input->param('error');
        my $authid=$input->param('authid'); # if authid exists, it's a modif, not a new authority.
        my $op = $input->param('op');
        my $nonav = $input->param('nonav');
        my $myindex = $input->param('index');
        my $linkid=$input->param('linkid');
        my $authtypecode = $input->param('authtypecode');
        my $breedingid    = $input->param('breedingid');
            my @tags = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values = $input->param('field_value');
            my @ind_tag = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            my $confirm_not_duplicate = $input->param('confirm_not_duplicate');
    grep -- '\$query->param' authorities/blinddetail-biblio-search.pl
        my $authid       = $query->param('authid');
        my $index        = $query->param('index');
        my $tagid        = $query->param('tagid');
        my $relationship = $query->param('relationship');
            my $repet = ($query->param('repet') || 1) - 1;
    grep -- '\$query->param' authorities/detail-biblio-search.pl
        my $authid = $query->param('authid');
        my $index = $query->param('index');
    grep -- '\$query->param' authorities/detail.pl
        my $authid = $query->param('authid');
    grep -- '\$query->param' authorities/export.pl
        my $op     = $query->param("op");
        my $format = $query->param("format");
            my $authid = $query->param("authid");
    grep -- '\$input->param' authorities/merge.pl
        my @authid = $input->param('authid');
        my $merge  = $input->param('merge');
            my $recordid1   = $input->param('recordid1');
            my $recordid2   = $input->param('recordid2');
            my $typecode = $input->param('frameworkcode');
                if ($input->param('mergereference') eq 'breeding') {
            my $mergereference = $input->param('mergereference');
                        $framework = $input->param('frameworkcode')
    grep -- '\$reply->param' authorities/merge_ajax.pl
        my $framework = $reply->param('frameworkcode');
    grep -- '\$query->param' authorities/ysearch.pl
            my @value      = $query->param('term');
            my $searchtype = $query->param('querytype');
            my $authtypecode = $query->param('authtypecode');
            my @and_or    = $query->param('and_or');
            my @excluding = $query->param('excluding');
            my @operator  = $query->param('operator');
            my $orderby   = $query->param('orderby');
    grep -- '\$query->param' basket/basket.pl
        my $bib_list     = $query->param('bib_list');
        my $print_basket = $query->param('print');
        my $verbose      = $query->param('verbose');
    grep -- '\$query->param' basket/downloadcart.pl
        my $bib_list = $query->param('bib_list');
        my $format  = $query->param('format');
    grep -- '\$query->param' basket/sendbasket.pl
        my $bib_list     = $query->param('bib_list');
        my $email_add    = $query->param('email_add');
        my $email_sender = $query->param('email_sender');
            my $comment    = $query->param('comment');
    grep -- '\$query->param' catalogue/ISBDdetail.pl
        my $biblionumber = $query->param('biblionumber');
            searchid            => $query->param('searchid'),
    grep -- '\$query->param' catalogue/MARCdetail.pl
        my $biblionumber = $query->param('biblionumber');
        my $frameworkcode = $query->param('frameworkcode');
          $query->param('popup')
        my $subscriptionid = $query->param('subscriptionid');
            searchid            => $query->param('searchid'),
    grep -- '\$query->param' catalogue/export.pl
        my $op=$query->param("op");
        my $format=$query->param("format");
            my $biblionumber = $query->param("bib");
    grep -- '\$cgi->param' catalogue/getitem-ajax.pl
        my $itemnumber = $cgi->param('itemnumber');
    grep -- '\$data->param' catalogue/image.pl
            if ( defined $data->param('imagenumber') ) {
                $imagenumber = $data->param('imagenumber');
            elsif ( defined $data->param('biblionumber') ) {
                my @imagenumbers = ListImagesForBiblio( $data->param('biblionumber') );
                    if ( $data->param('thumbnail') ) {
    grep -- '\$query->param' catalogue/imageviewer.pl
        my $biblionumber = $query->param('biblionumber') || $query->param('bib');
        my $imagenumber = $query->param('imagenumber');
    grep -- '\$cgi->param' catalogue/itemsearch.pl
        my $format = $cgi->param('format');
            $cgi->param('rows', $cgi->param('iDisplayLength'));
            $cgi->param('page', ($cgi->param('iDisplayStart') / $cgi->param('iDisplayLength')) + 1);
            my @columns = split /,/, $cgi->param('sColumns');
            $cgi->param('sortby', $columns[ $cgi->param('iSortCol_0') ]);
            $cgi->param('sortorder', $cgi->param('sSortDir_0'));
            my @f = $cgi->param('f');
            my @q = $cgi->param('q');
            my @op = $cgi->param('op');
            my @c = $cgi->param('c');
            foreach my $i (0 .. ($cgi->param('iColumns') - 1)) {
                my $sSearch = $cgi->param("sSearch_$i");
            $cgi->param('f', @f);
            $cgi->param('q', @q);
            $cgi->param('op', @op);
            $cgi->param('c', @c);
            $cgi->param('rows', 0);
                if (my @q = $cgi->param($p)) {
                        if (my $op = $cgi->param($p . '_op')) {
            my @c = $cgi->param('c');
            my @fields = $cgi->param('f');
            my @q = $cgi->param('q');
            my @op = $cgi->param('op');
                my $v = $cgi->param($p) // '';
            if (my $itemcallnumber_from = $cgi->param('itemcallnumber_from')) {
            if (my $itemcallnumber_to = $cgi->param('itemcallnumber_to')) {
                rows => $cgi->param('rows') // 20,
                page => $cgi->param('page') || 1,
                sortby => $cgi->param('sortby') || 'itemnumber',
                sortorder => $cgi->param('sortorder') || 'asc',
                    my @v = $cgi->param($p);
    grep -- '\$query->param' catalogue/labeledMARCdetail.pl
        my $biblionumber = $query->param('biblionumber');
        my $frameworkcode = $query->param('frameworkcode');
          $query->param('popup')
            searchid            => $query->param('searchid'),
    grep -- '\$query->param' catalogue/moredetail.pl
        my $subject=$query->param('subject');
        my $biblionumber=$query->param('biblionumber');
        my $title=$query->param('title');
        my $bi=$query->param('bi');
        my $itemnumber = $query->param('itemnumber');
        my $showallitems = $query->param('showallitems');
        $template->{'VARS'}->{'searchid'} = $query->param('searchid');
    grep -- '\$cgi->param' catalogue/search-history.pl
        my $type = $cgi->param('type');
        my $action = $cgi->param('action') || q{list};
        my $previous = $cgi->param('previous');
    grep -- '\$cgi->param' catalogue/search.pl
        my @params = $cgi->param("limit");
        if ((@params>=1) || ($cgi->param("q")) || ($cgi->param('multibranchlimit')) || ($cgi->param('limit-yr')) ) {
        #my @cgi_params_list = $cgi->param();
        #unless (($cgi->param('r')) || (!$cgi->param()) ) {
                my $expanded = $cgi->param('expanded_options');
        @sort_by = $cgi->param('sort_by');
        my @servers = $cgi->param('server');
        my @operators = map uri_unescape($_), $cgi->param('op');
        my @indexes = map uri_unescape($_), $cgi->param('idx');
        my @operands = map Encode::decode_utf8( uri_unescape($_) ), $cgi->param('q');
        my @limits = map uri_unescape($_), $cgi->param('limit');
        my @nolimits = map uri_unescape($_), $cgi->param('nolimit');
        my $page = $cgi->param('page') || 1;
                my $page = $cgi->param('page') || 0;
        $template->{'VARS'}->{'searchid'} = $cgi->param('searchid');
        my $gotonumber = $cgi->param('gotoNumber');
        my $gotopage = $cgi->param('gotoPage');
    grep -- '\$input->param' catalogue/showmarc.pl
        my $biblionumber= $input->param('id');
        my $importid= $input->param('importid');
        my $view= $input->param('viewas')||'';
    grep -- '\$cgi->param' catalogue/updateitem.pl
        my $biblionumber=$cgi->param('biblionumber');
        my $itemnumber=$cgi->param('itemnumber');
        my $biblioitemnumber=$cgi->param('biblioitemnumber');
        my $itemlost=$cgi->param('itemlost');
        my $itemnotes=$cgi->param('itemnotes');
        my $withdrawn=$cgi->param('withdrawn');
        my $damaged=$cgi->param('damaged');
        my $confirm=$cgi->param('confirm');
    grep -- '\$input->param' cataloguing/addbiblio.pl
        my $error = $input->param('error');
        my $biblionumber  = $input->param('biblionumber'); # if biblionumber exists, it's a modif, not a new biblio.
        my $parentbiblio  = $input->param('parentbiblionumber');
        my $breedingid    = $input->param('breedingid');
        my $z3950         = $input->param('z3950');
        my $op            = $input->param('op');
        my $mode          = $input->param('mode');
        my $frameworkcode = $input->param('frameworkcode');
        my $redirect      = $input->param('redirect');
        my $searchid      = $input->param('searchid');
        my $hostbiblionumber = $input->param('hostbiblionumber');
        my $hostitemnumber = $input->param('hostitemnumber');
        my $fa_circborrowernumber = $input->param('circborrowernumber');
        my $fa_barcode            = $input->param('barcode');
        my $fa_branch             = $input->param('branch');
        my $fa_stickyduedate      = $input->param('stickyduedate');
        my $fa_duedatespec        = $input->param('duedatespec');
        my $changed_framework = $input->param('changed_framework');
            my @params = $input->param();
            my $confirm_not_duplicate = $input->param('confirm_not_duplicate');
                my $tab = $input->param('current_tab');
            tab => $input->param('tab')
    grep -- '\$input->param' cataloguing/addbooks.pl
        my $success = $input->param('biblioitem');
        my $query   = $input->param('q');
        my @value   = $input->param('value');
        my $page    = $input->param('page') || 1;
    grep -- '\$input->param' cataloguing/additem.pl
                $value = $input->param('barcode');
        my $error        = $input->param('error');
        my $biblionumber = $input->param('biblionumber');
        my $itemnumber   = $input->param('itemnumber');
        my $op           = $input->param('op');
        my $hostitemnumber = $input->param('hostitemnumber');
        my $searchid     = $input->param('searchid');
        my $fa_circborrowernumber = $input->param('circborrowernumber');
        my $fa_barcode            = $input->param('barcode');
        my $fa_branch             = $input->param('branch');
        my $fa_stickyduedate      = $input->param('stickyduedate');
        my $fa_duedatespec        = $input->param('duedatespec');
        if (defined $input->param('frameworkcode')) {
            $userflags = ($input->param('frameworkcode') eq 'FA') ? "fast_cataloging" : "edit_items";
            my @tags      = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values    = $input->param('field_value');
            my @ind_tag   = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            my $add_submit                 = $input->param('add_submit');
            my $add_duplicate_submit       = $input->param('add_duplicate_submit');
            my $add_multiple_copies_submit = $input->param('add_multiple_copies_submit');
            my $number_of_copies           = $input->param('number_of_copies');
            my @tags      = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values    = $input->param('field_value');
            my @ind_tag   = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            # my $itemnumber = $input->param('itemnumber');
        my $branch = $input->param('branch') || C4::Context->userenv->{branch};
            popup => $input->param('popup') ? 1: 0,
    grep -- '\$input->param' cataloguing/additem.pl
                $value = $input->param('barcode');
        my $error        = $input->param('error');
        my $biblionumber = $input->param('biblionumber');
        my $itemnumber   = $input->param('itemnumber');
        my $op           = $input->param('op');
        my $hostitemnumber = $input->param('hostitemnumber');
        my $searchid     = $input->param('searchid');
        my $fa_circborrowernumber = $input->param('circborrowernumber');
        my $fa_barcode            = $input->param('barcode');
        my $fa_branch             = $input->param('branch');
        my $fa_stickyduedate      = $input->param('stickyduedate');
        my $fa_duedatespec        = $input->param('duedatespec');
        if (defined $input->param('frameworkcode')) {
            $userflags = ($input->param('frameworkcode') eq 'FA') ? "fast_cataloging" : "edit_items";
            my @tags      = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values    = $input->param('field_value');
            my @ind_tag   = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            my $add_submit                 = $input->param('add_submit');
            my $add_duplicate_submit       = $input->param('add_duplicate_submit');
            my $add_multiple_copies_submit = $input->param('add_multiple_copies_submit');
            my $number_of_copies           = $input->param('number_of_copies');
            my @tags      = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values    = $input->param('field_value');
            my @ind_tag   = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            # my $itemnumber = $input->param('itemnumber');
        my $branch = $input->param('branch') || C4::Context->userenv->{branch};
            popup => $input->param('popup') ? 1: 0,
    grep -- '\$input->param' cataloguing/merge.pl
        my @biblionumber = $input->param('biblionumber');
        my $merge = $input->param('merge');
            my $tobiblio     =  $input->param('biblio1');
            my $frombiblio   =  $input->param('biblio2');
            my $frameworkcode = $input->param('frameworkcode');
            biblio1 => $input->param('biblio1')
            my $mergereference = $input->param('mergereference');
            my $biblionumber = $input->param('biblionumber');
                        $framework = $input->param('frameworkcode')
    grep -- '\$reply->param' cataloguing/merge_ajax.pl
        my $framework = $reply->param('frameworkcode');
    grep -- '\$input->param' cataloguing/plugin_launcher.pl
        my $plugin_name="cataloguing/value_builder/".$input->param("plugin_name");
    grep -- '\$input->param' cataloguing/value_builder/macles.pl
            my $index= $input->param('index');
    grep -- '\$query->param' cataloguing/value_builder/marc21_linking_section.pl
               my $op        = $query->param('op');
           my $type      = $query->param('type');
         my $startfrom = $query->param('startfrom');
                    my $biblionumber = $query->param('biblionumber');
                      my $index        = $query->param('index');
                         index            => $query->param('index') . "",
                 my $search         = $query->param('search');
                  my $itype          = $query->param('itype');
                   my $startfrom      = $query->param('startfrom');
                       my $resultsperpage = $query->param('resultsperpage') || 20;
                              index          => $query->param('index') . "",
                                index        => $query->param('index'),
    grep -- '\$query->param' cataloguing/value_builder/unimarc_field_210c.pl
            my $op = $query->param('op');
            my $authtypecode = $query->param('authtypecode');
            my $index = $query->param('index');
            my $category = $query->param('category');
            my $resultstring = $query->param('result');
            my $startfrom=$query->param('startfrom');
                my @marclist = $query->param('marclist');
                my @and_or = $query->param('and_or');
                my @excluding = $query->param('excluding');
                my @operator = $query->param('operator');
                my @value = $query->param('value');
                my $orderby   = $query->param('orderby');
                $resultsperpage= $query->param('resultsperpage');
                $template->param('index' => $query->param('index'));
    grep -- '\$query->param' cataloguing/value_builder/unimarc_field_4XX.pl
            my $op        = $query->param('op');
            my $type      = $query->param('type');
            my $startfrom = $query->param('startfrom');
                my $biblionumber = $query->param('biblionumber');
                my $index  = $query->param('index');
                    index            => $query->param('index') . "",
                my $search         = $query->param('search');
                my $itype          = $query->param('itype');
                my $startfrom      = $query->param('startfrom');
                my $resultsperpage = $query->param('resultsperpage') || 20;
                    index          => $query->param('index') . "",
                    index        => $query->param('index'),
    grep -- '\$input->param' cataloguing/ysearch.pl
        my $query = $input->param('term');
        my $table = $input->param('table');
        my $field = $input->param('field');
    grep -- '\$input->param' cataloguing/z3950_auth_search.pl
        my $error         = $input->param('error');
        my $authid  = $input->param('authid') || 0;
        my $nameany     = $input->param('nameany');
        my $authorany     = $input->param('authorany');
        my $authorcorp     = $input->param('authorcorp');
        my $authorpersonal     = $input->param('authorpersonal');
        my $authormeetingcon     = $input->param('authormeetingcon');
        my $title         = $input->param('title');
        my $uniformtitle         = $input->param('uniformtitle');
        my $subject       = $input->param('subject');
        my $subjectsubdiv       = $input->param('subjectsubdiv');
        my $srchany       = $input->param('srchany');
        my $op            = $input->param('op')||'';
        my $page            = $input->param('current_page') || 1;
        $page = $input->param('goto_page') if $input->param('changepage_goto');
        my @id = $input->param('id');
                random => $input->param('random') || rand(1000000000),
    grep -- '\$input->param' cataloguing/z3950_search.pl
        my $error         = $input->param('error');
        my $biblionumber  = $input->param('biblionumber') || 0;
        my $frameworkcode = $input->param('frameworkcode');
        my $title         = $input->param('title');
        my $author        = $input->param('author');
        my $isbn          = $input->param('isbn');
        my $issn          = $input->param('issn');
        my $lccn          = $input->param('lccn');
        my $lccall        = $input->param('lccall');
        my $subject       = $input->param('subject');
        my $dewey         = $input->param('dewey');
        my $controlnumber = $input->param('controlnumber');
        my $stdid         = $input->param('stdid');
        my $srchany       = $input->param('srchany');
        my $op            = $input->param('op')||'';
        my $page            = $input->param('current_page') || 1;
        $page = $input->param('goto_page') if $input->param('changepage_goto');
        my @id = $input->param('id');
    grep -- '\$query->param' changelanguage.pl
        my $language = $query->param('language');
    grep -- '\$input->param' circ/add_message.pl
        my $borrowernumber   = $input->param('borrowernumber');
        my $branchcode       = $input->param('branchcode');
        my $message_type     = $input->param('message_type');
        my $borrower_message = $input->param('borrower_message');
    grep -- '\$input->param' circ/bookcount.pl
        my $itm          = $input->param('itm');
        my $bi           = $input->param('bi');
        my $biblionumber = $input->param('biblionumber');
    grep -- '\$input->param' circ/branchoverdues.pl
        my $borrowernumber = $input->param('borrowernumber');
        my $itemnumber     = $input->param('itemnumber');
        my $method         = $input->param('method');
        my $overduelevel   = $input->param('overduelevel');
        my $notifyId       = $input->param('notifyId');
        my $location       = $input->param('location');
        if ( $input->param('action') eq 'add' ) {
        elsif ( $input->param('action') eq 'remove' ) {
            my $notify_date  = $input->param('notify_date');
    grep -- '\$query->param' circ/branchtransfers.pl
        my $request        = $query->param('request')        || '';
        my $borrowernumber = $query->param('borrowernumber') ||  0;
        my $tobranchcd     = $query->param('tobranchcd')     || '';
            my $item = $query->param('itemnumber');
            my $item = $query->param('itemnumber');
            my $biblio = $query->param('biblionumber');
        my $barcode = $query->param('barcode');
        foreach ( $query->param ) {
            my $bc    = $query->param("bc-$counter");
            my $frbcd = $query->param("fb-$counter");
            my $tobcd = $query->param("tb-$counter");
    grep -- '\$query->param' circ/circulation.pl
        my $branch = $query->param('branch');
        my $printer = $query->param('printer');
        my $force_allow_issue = $query->param('forceallow') || 0;
        my $onsite_checkout = $query->param('onsite_checkout');
        my @failedrenews = $query->param('failedrenew');    # expected to be itemnumbers
        my @failedreturns = $query->param('failedreturn');
        my $findborrower = $query->param('findborrower') || q{};
        my $borrowernumber = $query->param('borrowernumber');
        my $barcode        = $query->param('barcode') || q{};
        my $stickyduedate  = $query->param('stickyduedate') || $session->param('stickyduedate');
        my $duedatespec    = $query->param('duedatespec')   || $session->param('stickyduedate');
        my $issueconfirmed = $query->param('issueconfirmed');
        my $cancelreserve  = $query->param('cancelreserve');
        my $print          = $query->param('print') || q{};
        my $debt_confirmed = $query->param('debt_confirmed') || 0; # Don't show the debt error dialog twice
        my $charges        = $query->param('charges') || q{};
            if ( $stickyduedate && ! $query->param("stickyduedate") ) {
                $stickyduedate  = $query->param('stickyduedate');
                $duedatespec    = $query->param('duedatespec');
            $session->param('auto_renew', $query->param('auto_renew'));
        my $inprocess = ($barcode eq '') ? '' : $query->param('inprocess');
            $query->param( 'borrowernumber', '' );
                $query->param( 'findborrower', '' );
                $query->param( 'borrowernumber', $borrowernumber );
                $query->param( 'barcode',           '' );
                    if ( ! $query->param('module') || $query->param('module') ne 'returns' ) {
            was_renewed       => $query->param('was_renewed') ? 1 : 0,
    grep -- '\$input->param' circ/del_message.pl
        my $borrowernumber = $input->param('borrowernumber');
        my $message_id     = $input->param('message_id');
    grep -- '\$input->param' circ/hold-transfer-slip.pl
        my $biblionumber = $input->param('biblionumber');
        my $borrowernumber = $input->param('borrowernumber');
        my $transfer = $input->param('transfer');
    grep -- '\$input->param' circ/overdue.pl
        my $order           = $input->param('order') || '';
        my $showall         = $input->param('showall');
        my $bornamefilter   = $input->param('borname') || '';
        my $borcatfilter    = $input->param('borcat') || '';
        my $itemtypefilter  = $input->param('itemtype') || '';
        my $borflagsfilter  = $input->param('borflag') || '';
        my $branchfilter    = $input->param('branch') || '';
        my $homebranchfilter    = $input->param('homebranch') || '';
        my $holdingbranchfilter = $input->param('holdingbranch') || '';
        my $op              = $input->param('op') || '';
        my $dateduefrom = format_date_in_iso($input->param( 'dateduefrom' )) || '';
        my $datedueto   = format_date_in_iso($input->param( 'datedueto' )) || '';
        for my $attrcode (grep { /^patron_attr_filter_/ } $input->param) {
            if (my @attrvalues = grep { length($_) > 0 } $input->param($attrcode)) {
            dateduefrom => $input->param( 'dateduefrom' ) || '',
            datedueto   => $input->param( 'datedueto' ) || '',
    grep -- '\$input->param' circ/pendingreserves.pl
        my $startdate=$input->param('from');
        my $enddate=$input->param('to');
        my $run_report = ( not defined $input->param('run_report') ) ? 1 : $input->param('run_report');
        my $theme = $input->param('theme');    # only used if allowthemeoverride is set
    grep -- '\$cgi->param' circ/renew.pl
        my $barcode        = $cgi->param('barcode');
        my $override_limit = $cgi->param('override_limit');
        my $override_holds = $cgi->param('override_holds');
    grep -- '\$input->param' circ/reserveratios.pl
        my $startdate = $input->param('from');
        my $enddate   = $input->param('to');
        my $ratio     = $input->param('ratio');
        my $booksellerid = $input->param('booksellerid') // '';
        my $basketno = $input->param('basketno') // '';
    grep -- '\$query->param' circ/returns.pl
        foreach ( $query->param ) {
            my $barcode        = $query->param("ri-$counter");
            my $duedate        = $query->param("dd-$counter");
            my $borrowernumber = $query->param("bn-$counter");
        if ($query->param('WT-itemNumber')){
            updateWrongTransfer ($query->param('WT-itemNumber'),$query->param('WT-waitingAt'),$query->param('WT-From'));
        if ( $query->param('resbarcode') ) {
            my $item           = $query->param('itemnumber');
            my $borrowernumber = $query->param('borrowernumber');
            my $resbarcode     = $query->param('resbarcode');
            my $diffBranchReturned = $query->param('diffBranch');
        my $barcode     = $query->param('barcode');
        my $exemptfine  = $query->param('exemptfine');
        my $dropboxmode = $query->param('dropboxmode');
        my $dotransfer  = $query->param('dotransfer');
        my $canceltransfer = $query->param('canceltransfer');
        my $dest = $query->param('dest');
        my $return_date_override = $query->param('return_date_override');
          $query->param('return_date_override_remember');
            my $transferitem = $query->param('transferitem');
            my $tobranch     = $query->param('tobranch');
            $itemnumber=$query->param('itemnumber');
        $itemnumber = GetItemnumberFromBarcode( $query->param('barcode') );
    grep -- '\$input->param' circ/stats.pl
        my $time  = $input->param('time') || '';
    grep -- '\$input->param' circ/transfer-slip.pl
        my $itemnumber = $input->param('transferitem');
        my $branchcode = $input->param('branchcode');
    grep -- '\$input->param' circ/transferstoreceive.pl
        my $itemnumber = $input->param('itemnumber');
    grep -- '\$input->param' circ/waitingreserves.pl
        my $item           = $input->param('itemnumber');
        my $borrowernumber = $input->param('borrowernumber');
        my $fbr            = $input->param('fbr') || '';
        my $tbr            = $input->param('tbr') || '';
        my $all_branches   = $input->param('allbranches') || '';
        my $cancelall      = $input->param('cancelall');
    grep -- '\$input->param' circ/ypattrodue-attr-search-authvalue.pl
        my $query    = $input->param('term');
    grep -- '\$input->param' circ/ysearch.pl
        my $query   = $input->param('term');
    grep -- '\$cgi->param' course_reserves/add_items.pl
        my $action    = $cgi->param('action')    || '';
        my $course_id = $cgi->param('course_id') || '';
        my $barcode   = $cgi->param('barcode')   || '';
                itemnumber    => $cgi->param('itemnumber'),
                itype         => $cgi->param('itype'),
                ccode         => $cgi->param('ccode'),
                holdingbranch => $cgi->param('holdingbranch'),
                location      => $cgi->param('location'),
                staff_note  => $cgi->param('staff_note'),
                public_note => $cgi->param('public_note'),
    grep -- '\$cgi->param' course_reserves/course-details.pl
        my $action = $cgi->param('action') || '';
        my $course_id = $cgi->param('course_id');
            DelCourseReserve( cr_id => $cgi->param('cr_id') );
    grep -- '\$cgi->param' course_reserves/course-reserves.pl
        my $search_on = $cgi->param('search_on');
    grep -- '\$cgi->param' course_reserves/course.pl
        my $course_id = $cgi->param('course_id');
    grep -- '\$cgi->param' course_reserves/mod_course.pl
        my $action = $cgi->param('action') || '';
            DelCourse( $cgi->param('course_id') );
            $params{'course_id'} = $cgi->param('course_id')
              if ( $cgi->param('course_id') );
            $params{'department'}     = $cgi->param('department');
            $params{'course_number'}  = $cgi->param('course_number');
            $params{'section'}        = $cgi->param('section');
            $params{'course_name'}    = $cgi->param('course_name');
            $params{'term'}           = $cgi->param('term');
            $params{'staff_note'}     = $cgi->param('staff_note');
            $params{'public_note'}    = $cgi->param('public_note');
            $params{'students_count'} = $cgi->param('students_count');
            $params{'enabled'}        = ( $cgi->param('enabled') eq 'on' ) ? 'yes' : 'no';
            my @instructors = $cgi->param('instructors');
    grep -- '\$cgi->param' docs/CAS/CASProxy/examples/proxy_cas.pl
        if ($cgi->param('ticket')) {
            print "Got a ticket :" . $cgi->param('ticket') . "<br>\n";
            my $r = $cas->service_validate( $proxy_service, $cgi->param('ticket'), pgtUrl => $pgtUrl);
    grep -- '\$cgi->param' docs/CAS/CASProxy/examples/proxy_cas_callback.pl
        if ($cgi->param('pgtId')) {
            warn "Got a pgtId :" . $cgi->param('pgtId');
            warn "Got a pgtIou :" . $cgi->param('pgtIou');
            my $pgtIou =  $cgi->param('pgtIou');
            my $pgtId =  $cgi->param('pgtId');
    grep -- '\$cgi->param' docs/CAS/CASProxy/examples/proxy_cas_data.pl
        if ($cgi->param('PGTIOU')) {
              my $pgtId = %$hashref->{$cgi->param('PGTIOU')};
    grep -- '\$input->param' edithelp.pl
        my $type    = $input->param('type') || '';
        my $referer = $input->param('referer') || '';
        my $help    = $input->param('help') || '';
    grep -- '\$query->param' help.pl
        our $refer = $query->param('url');
    grep -- '\$query->param' installer/install.pl
        my $step  = $query->param('step');
        my $language = $query->param('language');
            my $checkdb = $query->param("checkdb");
            my $op = $query->param('op');
                my ($fwk_language, $list) = $installer->load_sql_in_order($all_languages, $query->param('framework'));
                my $langchoice = $query->param('fwklanguage');
                my $marcflavour = $query->param('marcflavour');
                my $langchoice = $query->param('fwklanguage');
    grep -- '\$cgi->param' labels/label-create-csv.pl
        $batch_id    = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $template_id = $cgi->param('template_id') || undef;
        my $layout_id   = $cgi->param('layout_id') || undef;
        @label_ids   = $cgi->param('label_id') if $cgi->param('label_id');
        @item_numbers  = $cgi->param('item_number') if $cgi->param('item_number');
    grep -- '\$cgi->param' labels/label-create-pdf.pl
        $batch_id    = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $template_id = $cgi->param('template_id') || undef;
        my $layout_id   = $cgi->param('layout_id') || undef;
        my $start_label = $cgi->param('start_label') || 1;
        @label_ids   = $cgi->param('label_id') if $cgi->param('label_id');
        @item_numbers  = $cgi->param('item_number') if $cgi->param('item_number');
    grep -- '\$cgi->param' labels/label-create-xml.pl
        $batch_id    = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $template_id = $cgi->param('template_id') || undef;
        my $layout_id   = $cgi->param('layout_id') || undef;
        @label_ids   = $cgi->param('label_id') if $cgi->param('label_id');
        @item_numbers  = $cgi->param('item_number') if $cgi->param('item_number');
    grep -- '\$cgi->param' labels/label-edit-batch.pl
        my $op = $cgi->param('op') || 'edit';
        my $batch_id = $cgi->param('element_id') || $cgi->param('batch_id') || undef;
        @label_ids = $cgi->param('label_id') if $cgi->param('label_id');
        @item_numbers = $cgi->param('item_number') if $cgi->param('item_number');
        $barcode = $cgi->param('barcode') if $cgi->param('barcode');
    grep -- '\$cgi->param' labels/label-edit-layout.pl
        my $op = $cgi->param('op') || '';
        my $layout_id = $cgi->param('layout_id') || $cgi->param('element_id') || '';
        my $layout_choice = $cgi->param('layout_choice') || '';
                foreach my $cgi_param ($cgi->param()) {
                    if (($cgi_param =~ m/^(.*)_tbl$/) && ($cgi->param($cgi_param))) {
                        my $value = $cgi->param($cgi_param);
                $cgi->param('format_string', $format_string);
                            barcode_type    => $cgi->param('barcode_type') || 'CODE39',
                            printing_type   => $cgi->param('printing_type') || 'BAR',
                            layout_name     => $cgi->param('layout_name') || 'DEFAULT',
                            guidebox        => ($cgi->param('guidebox') ? 1 : 0),
                            font            => $cgi->param('font') || 'TR',
                            font_size       => $cgi->param('font_size') || 3,
                            callnum_split   => ($cgi->param('callnum_split') ? 1 : 0),
                            text_justify    => $cgi->param('text_justify') || 'L',
                            format_string   => $cgi->param('format_string') || 'title, author, isbn, issn, itemtype, barcode, itemcallnumber',
    grep -- '\$cgi->param' labels/label-edit-profile.pl
        my $op = $cgi->param('op');
        my $profile_id = $cgi->param('profile_id') || $cgi->param('element_id');
                printer_name        => $cgi->param('printer_name') || 'DEFAULT PRINTER',
                paper_bin           => $cgi->param('paper_bin') || 'Tray 1',
                offset_horz         => $cgi->param('offset_horz') || 0,
                offset_vert         => $cgi->param('offset_vert') || 0,
                creep_horz          => $cgi->param('creep_horz') || 0,
                creep_vert          => $cgi->param('creep_vert') || 0,
                units               => $cgi->param('units') || 'POINT',
    grep -- '\$cgi->param' labels/label-edit-template.pl
        my $op = $cgi->param('op');
        my $template_id = $cgi->param('template_id') || $cgi->param('element_id');
            my @params = (      profile_id      => $cgi->param('profile_id'),
                                template_code   => $cgi->param('template_code') || 'DEFAULT_TEMPLATE',
                                template_desc   => $cgi->param('template_desc') || 'Default description',
                                page_width      => $cgi->param('page_width') || 0,
                                page_height     => $cgi->param('page_height') || 0,
                                label_width     => $cgi->param('label_width') || 0,
                                label_height    => $cgi->param('label_height') || 0,
                                top_text_margin => $cgi->param('top_text_margin') || 0,
                                left_text_margin=> $cgi->param('left_text_margin') || 0,
                                top_margin      => $cgi->param('top_margin') || 0,
                                left_margin     => $cgi->param('left_margin') || 0,
                                cols            => $cgi->param('cols') || 0,
                                rows            => $cgi->param('rows') || 0,
                                col_gap         => $cgi->param('col_gap') || 0,
                                row_gap         => $cgi->param('row_gap') || 0,
                                units           => $cgi->param('units') || 'POINT',
                if ($cgi->param('profile_id') && ($label_template->get_attr('template_id') != $cgi->param('profile_id'))) {
                    my $new_profile = C4::Labels::Profile->retrieve(profile_id => $cgi->param('profile_id'));
                elsif ($cgi->param('profile_id') == 0) { # Disassociate any printer profile from the template
                if ($cgi->param('profile_id')) {
                    my $profile = C4::Labels::Profile->retrieve(profile_id => $cgi->param('profile_id'));
    grep -- '\$query->param' labels/label-item-search.pl
        my $type      = $query->param('type');
        my $op        = $query->param('op') || '';
        my $batch_id  = $query->param('batch_id');
        my $ccl_query = $query->param('ccl_query');
        my $startfrom = $query->param('startfrom') || 1;
            $idx         = $query->param('idx');
            $ccl_textbox = $query->param('ccl_textbox');
            $datefrom = $query->param('datefrom');
            $dateto   = $query->param('dateto');
    grep -- '\$cgi->param' labels/label-manage.pl
        my $label_element = $cgi->param('label_element') || 'template';   # default to template managment
        my $op = $cgi->param('op') || 'none';
        my $element_id = $cgi->param('element_id') || undef;
        my $error = $cgi->param('error') || 0;
    grep -- '\$cgi->param' labels/label-print.pl
        my $op = $cgi->param('op') || 'none';
        @label_ids = $cgi->param('label_id') if $cgi->param('label_id');   # this will handle individual label printing
        @batch_ids = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $layout_id = $cgi->param('layout_id') || undef;
        my $template_id = $cgi->param('template_id') || undef;
        my $start_label = $cgi->param('start_label') || 1;
        @item_numbers = $cgi->param('item_number') if $cgi->param('item_number');
        my $output_format = $cgi->param('output_format') || 'pdf';
        my $referer = $cgi->param('referer') || undef;
    grep -- '\$query->param' labels/spinelabel-print.pl
        my $barcode = $query->param('barcode');
    grep -- '\$input->param' members/boraccount.pl
        my $borrowernumber=$input->param('borrowernumber');
        my $action = $input->param('action') || '';
          ReversePayment( $input->param('accountlines_id') );
    grep -- '\$input->param' members/deletemem.pl
        my $member       = $input->param('member');
        my $deletelocal  = $input->param('deletelocal')  eq 'false' ? 0 : 1; # Deleting locally is the default
            if ( $input->param('deleteremote') eq 'true' ) {
    grep -- '\$input->param' members/guarantor_search.pl
        my $member        = $input->param('member') // '';
        my $orderby       = $input->param('orderby');
        my $category_type = $input->param('category_type');
    grep -- '\$input->param' members/mancredit.pl
        my $borrowernumber=$input->param('borrowernumber');
        my $add=$input->param('add');
                my $barcode = $input->param('barcode');
                my $desc    = $input->param('desc');
                my $note    = $input->param('note');
                my $amount  = $input->param('amount') || 0;
                my $type = $input->param('type');
    grep -- '\$input->param' members/maninvoice.pl
        my $borrowernumber=$input->param('borrowernumber');
        my $add=$input->param('add');
                my $barcode=$input->param('barcode');
                my $desc=$input->param('desc');
                my $amount=$input->param('amount');
                my $type=$input->param('type');
                my $note    = $input->param('note');
    grep -- '\$input->param' members/member-flags.pl
        my $member=$input->param('member');
        if ($input->param('newflags')) {
            my @perms = $input->param('flag');
    grep -- '\$input->param' members/member-password.pl
        my $theme = $input->param('theme') || "default";
        my $member=$input->param('member');
        my $cardnumber = $input->param('cardnumber');
        my $destination = $input->param('destination');
        my $newpassword = $input->param('newpassword');
        my $newpassword2 = $input->param('newpassword2');
            my $digest=Koha::AuthUtils::hash_password($input->param('newpassword'));
            my $uid = $input->param('newuserid');
    grep -- '\$input->param' members/member.pl
        my $theme = $input->param('theme') || "default";
        my $searchmember = $input->param('searchmember');
        my $quicksearch = $input->param('quicksearch') // 0;
        my $searchfieldstype = $input->param('searchfieldstype') || 'standard';
            searchtype          => $input->param('searchtype') || 'start_with',
    grep -- '\$input->param' members/memberentry.pl
        ($debug) or $debug = $input->param('debug') || 0;
        my $guarantorid    = $input->param('guarantorid');
        my $borrowernumber = $input->param('borrowernumber');
        my $actionType     = $input->param('actionType') || '';
        my $modify         = $input->param('modify');
        my $delete         = $input->param('delete');
        my $op             = $input->param('op');
        my $destination    = $input->param('destination');
        my $cardnumber     = $input->param('cardnumber');
        my $check_member   = $input->param('check_member');
        my $nodouble       = $input->param('nodouble');
        my $duplicate      = $input->param('duplicate');
        my $select_city   = $input->param('select_city');
        my $nok           = $input->param('nok');
        my $guarantorinfo = $input->param('guarantorinfo');
        my $step          = $input->param('step') || 0;
        my $check_categorytype=$input->param('check_categorytype');
        my @debarments_to_remove = $input->param('remove_debarment');
        if ( $input->param('add_debarment') ) {
            my $expiration = $input->param('debarred_expiration');
                    comment        => $input->param('debarred_comment'),
        my $categorycode  = $input->param('categorycode') || $borrower_data->{'categorycode'};
        my $category_type = $input->param('category_type') || '';
        my %newdata;                                                                             # comes from $input->param()
            my @names = ( $borrower_data && $op ne 'save' ) ? keys %$borrower_data : $input->param();
                if (defined $input->param($key)) {
                    $newdata{$key} = $input->param($key);
        $newdata{'city'}    = $input->param('city')    if defined($input->param('city'));
        $newdata{'zipcode'} = $input->param('zipcode') if defined($input->param('zipcode'));
        $newdata{'country'} = $input->param('country') if defined($input->param('country'));
          my $password = $input->param('password');
          my $password2 = $input->param('password2');
                defined $input->param('SMSnumber')
                   $input->param('SMSnumber') eq ""
                or $input->param('SMSnumber') ne $newdata{'mobile'}
            $newdata{smsalertnumber} = $input->param('SMSnumber');
                if (C4::Context->preference('ExtendedPatronAttributes') and $input->param('setting_extended_patron_attributes')) {
                if (C4::Context->preference('EnhancedMessagingPreferences') and $input->param('setting_messaging_prefs')) {
                if (C4::Context->preference('ExtendedPatronAttributes') and $input->param('setting_extended_patron_attributes')) {
                if (C4::Context->preference('EnhancedMessagingPreferences') and $input->param('setting_messaging_prefs')) {
            my @patron_attr = grep { /^patron_attr_\d+$/ } $input->param();
                my $value = $input->param($key);
                my $password = $input->param("${key}_password");
                my $code     = $input->param("${key}_code");
    grep -- '\$query->param' members/members-home.pl
        my $branch = $query->param('branchcode');
    grep -- '\$query->param' members/members-update-do.pl
        my @params = $query->param;
                my $action = $query->param($param);
    grep -- '\$cgi->param' members/mod_debarment.pl
        my $borrowernumber = $cgi->param('borrowernumber');
        my $action         = $cgi->param('action');
            DelDebarment( $cgi->param('borrower_debarment_id') );
            my $expiration = $cgi->param('expiration');
                    comment        => $cgi->param('comment'),
    grep -- '\$input->param' members/notices.pl
        my $borrowernumber = $input->param('borrowernumber');
    grep -- '\$data->param' members/patronimage.pl
        if ($data->param('borrowernumber')) {
            $borrowernumber = $data->param('borrowernumber');
    grep -- '\$input->param' members/printfeercpt.pl
        my $borrowernumber=$input->param('borrowernumber');
        my $action = $input->param('action') || '';
        my $accountlines_id = $input->param('accountlines_id');
        #  ReversePayment( $borrowernumber, $input->param('accountno') );
    grep -- '\$input->param' members/printinvoice.pl
        my $borrowernumber  = $input->param('borrowernumber');
        my $action          = $input->param('action') || '';
        my $accountlines_id = $input->param('accountlines_id');
    grep -- '\$input->param' members/printslip.pl
        $debug or $debug = $input->param('debug') || 0;
        my $print = $input->param('print');
        my $error = $input->param('error');
        my $borrowernumber = $input->param('borrowernumber');
    grep -- '\$input->param' members/purchase-suggestions.pl
        my $borrowernumber = $input->param('borrowernumber');
    grep -- '\$query->param' members/routing-lists.pl
        my $branch = $query->param('branch');
        my $findborrower = $query->param('findborrower');
        my $borrowernumber = $query->param('borrowernumber');
    grep -- '\$input->param' members/setstatus.pl
        my $destination = $input->param("destination") || '';
        my $cardnumber = $input->param("cardnumber");
        my $borrowernumber=$input->param('borrowernumber');
        my $status = $input->param('status');
        my $reregistration = $input->param('reregistration') || '';
    grep -- '\$input->param' members/statistics.pl
        my $borrowernumber = $input->param('borrowernumber');
    grep -- '\$input->param' members/update-child.pl
        my $borrowernumber = $input->param('borrowernumber');
        my $catcode        = $input->param('catcode');
        my $cattype        = $input->param('cattype');
        my $catcode_multi = $input->param('catcode_multi');
        my $op             = $input->param('op');
    grep -- '\$query->param' offline_circ/download.pl
        my $page     = $query->param('page') || 0;
        my $req_data = $query->param('data') || '';
    grep -- '\$cgi->param' opac/ilsdi.pl
        unless ( $cgi->param('service') ) {
        if ( $cgi->param('service') eq "Describe" and any { $cgi->param('verb') eq $_ } @services ) {
            $template->param( $cgi->param('verb') => 1 );
        my $service = $cgi->param('service') || "ilsdi";
            my @names         = $cgi->param;
                my @values = $cgi->param($_);
    grep -- '\$query->param' opac/opac-MARCdetail.pl
        my $biblionumber = $query->param('biblionumber');
    grep -- '\$query->param' opac/opac-addbybiblionumber.pl
        our @biblionumber   = $query->param('biblionumber');
        our $selectedshelf  = $query->param('selectedshelf');
        our $newshelf       = $query->param('newshelf');
        our $shelfnumber    = $query->param('shelfnumber');
        our $newvirtualshelf    = $query->param('newvirtualshelf');
        our $category       = $query->param('category');
                my ($singleshelf, $singleshelfname)= GetShelf($query->param('selectedshelf'));
    grep -- '\$query->param' opac/opac-alert-subscribe.pl
        my $op    = $query->param('op') || '';
        my $externalid   = $query->param('externalid');
        my $alerttype    = $query->param('alerttype') || '';
        my $biblionumber = $query->param('biblionumber');
    grep -- '\$query->param' opac/opac-authorities-home.pl
        my $op           = $query->param('op') || '';
        my $authtypecode = $query->param('authtypecode') || '';
        my $startfrom = $query->param('startfrom');
        my $authid    = $query->param('authid');
            my @marclist = ($query->param('marclist'));
            my @and_or = ($query->param('and_or'));
            my @excluding = ($query->param('excluding'),);
            my @operator = ($query->param('operator'));
            my $orderby = $query->param('orderby');
            my @value = ($query->param('value') || "",);
            $resultsperpage = $query->param('resultsperpage');
    grep -- '\$query->param' opac/opac-authoritiesdetail.pl
        my $show_marc = $query->param('marc');
        my $authid = $query->param('authid');
    grep -- '\$query->param' opac/opac-basket.pl
        my $bib_list     = $query->param('bib_list');
        my $print_basket = $query->param('print');
        my $verbose      = $query->param('verbose');
    grep -- '\$query->param' opac/opac-browser.pl
        my $level = $query->param('level') || 0;
        my $filter = $query->param('filter');
    grep -- '\$query->param' opac/opac-changelanguage.pl
        my $language = $query->param('language');
    grep -- '\$cgi->param' opac/opac-course-details.pl
        my $course_id = $cgi->param('course_id');
    grep -- '\$query->param' opac/opac-detail.pl
        my $biblionumber = $query->param('biblionumber') || $query->param('bib') || 0;
        my $viewallitems = $query->param('viewallitems');
            my $starting_itemnumber = $query->param('shelfbrowse_itemnumber');
            $template->{VARS}->{query_desc} = $query->param('query_desc');
    grep -- '\$query->param' opac/opac-downloadcart.pl
        my $bib_list = $query->param('bib_list');
        my $format  = $query->param('format');
    grep -- '\$query->param' opac/opac-downloadshelf.pl
        my $shelfid = $query->param('shelfid');
        my $format  = $query->param('format');
        my $context = $query->param('context');
        my $showprivateshelves = $query->param('showprivateshelves');
    grep -- '\$query->param' opac/opac-export.pl
        my $op=$query->param("op")||''; #op=export is currently the only use
        my $format=$query->param("format")||'utf8';
        my $biblionumber = $query->param("bib")||0;
    grep -- '\$data->param' opac/opac-image.pl
            if ( defined $data->param('imagenumber') ) {
                $imagenumber = $data->param('imagenumber');
            elsif ( defined $data->param('biblionumber') ) {
                my @imagenumbers = ListImagesForBiblio( $data->param('biblionumber') );
                    if ( $data->param('thumbnail') ) {
    grep -- '\$query->param' opac/opac-imageviewer.pl
        my $biblionumber = $query->param('biblionumber') || $query->param('bib');
        my $imagenumber = $query->param('imagenumber');
    grep -- '\$cgi->param' opac/opac-memberentry.pl
        my $action = $cgi->param('action') || q{};
                md5_base64( $cgi->param('captcha') ) ne $cgi->param('captcha_digest') )
            foreach ( $cgi->param ) {
                    $borrower{$key} = $scrubber->scrub( $cgi->param($_) );
    grep -- '\$query->param' opac/opac-modrequest-suspend.pl
        my $suspend       = $query->param('suspend');
        my $suspend_until = $query->param('suspend_until') || undef;
        my $reserve_id    = $query->param('reserve_id');
    grep -- '\$query->param' opac/opac-modrequest.pl
        my $reserve_id = $query->param('reserve_id');
    grep -- '\$cgi->param' opac/opac-overdrive-search.pl
        $template->{'VARS'}->{'q'} = $cgi->param('q');
    grep -- '\$query->param' opac/opac-passwd.pl
            if (   $query->param('Oldkey')
                && $query->param('Newkey')
                && $query->param('Confirm') )
                if ( goodkey( $dbh, $borrowernumber, $query->param('Oldkey') ) ) {
                    if ( $query->param('Newkey') eq $query->param('Confirm')
                        && length( $query->param('Confirm') ) >= $minpasslen )
                        my $clave = hash_password( $query->param('Newkey') );
                    elsif ( $query->param('Newkey') ne $query->param('Confirm') ) {
                    elsif ( length( $query->param('Confirm') ) < $minpasslen ) {
                if (!$query->param('Oldkey') && ($query->param('Newkey') || $query->param('Confirm'))){
                elsif ($query->param('Oldkey') && (!$query->param('Newkey') || !$query->param('Confirm'))){
    grep -- '\$query->param' opac/opac-privacy.pl
        my $op = $query->param("op");
        my $privacy = $query->param("privacy");
    grep -- '\$query->param' opac/opac-readingrecord.pl
        my $order = $query->param('order') || '';
        my $limit = $query->param('limit');
    grep -- '\$cgi->param' opac/opac-registration-verify.pl
        my $token = $cgi->param('token');
    grep -- '\$query->param' opac/opac-renew.pl
        my @items = $query->param('item');
    grep -- '\$query->param' opac/opac-reserve.pl
        my $biblionumbers = $query->param('biblionumbers');
        my $reserveMode = $query->param('reserve_mode');
            my $bib = $query->param('single_bib');
            $biblionumbers = $query->param('biblionumber');
        if ((! $biblionumbers) && (! $query->param('place_reserve'))) {
        if (($#biblionumbers < 0) && (! $query->param('place_reserve'))) {
        my $branch = $query->param('branch') || $borr->{'branchcode'} || C4::Context->userenv->{branch} || '' ;
        if ( $query->param('place_reserve') ) {
            my $selectedItems = $query->param('selecteditems');
            if ($query->param('reserve_mode') eq 'single') {
                my $bib = $query->param('single_bib');
                my $item = $query->param("checkitem_$bib");
                my $branch = $query->param('branch');
                    $startdate = $query->param("reserve_date_$biblioNum");
                my $expiration_date = $query->param("expiration_date_$biblioNum");
                my $notes = $query->param('notes_'.$biblioNum)||'';
    grep -- '\$query->param' opac/opac-review.pl
        my $biblionumber = $query->param('biblionumber');
        my $review       = $query->param('review');
            'reviewid'       => $query->param('reviewid') || 0,
    grep -- '\$cgi->param' opac/opac-search-history.pl
        my $type = $cgi->param('type');
        my $action = $cgi->param('action') || q{};
        my $previous = $cgi->param('previous');
            if ($cgi->param('action') && $cgi->param('action') eq 'delete') {
                my $type = $cgi->param('type');
    grep -- '\$cgi->param' opac/opac-search.pl
        my $branch_group_limit = $cgi->param("branch_group_limit");
                $cgi->param(
        my @params = $cgi->param("limit");
        my $format = $cgi->param("format") || '';
        elsif ((@params>=1) || ($cgi->param("q")) || ($cgi->param('multibranchlimit')) || ($cgi->param('limit-yr')) ) {
        #my @cgi_params_list = $cgi->param();
        #unless (($cgi->param('r')) || (!$cgi->param()) ) {
            if (defined $cgi->param('expanded_options')) {
                if ( ($cgi->param('expanded_options') == 0) || ($cgi->param('expanded_options') == 1 ) ) {
                    $template->param( expanded_options => $cgi->param('expanded_options'));
            my @pasarParam = $cgi->param($_);
        @sort_by = $cgi->param('sort_by');
        my @servers = $cgi->param('server');
        my @operators = $cgi->param('op');
        my @indexes = $cgi->param('idx');
        my @operands = $cgi->param('q');
        my @limits = $cgi->param('limit');
        my @nolimits = $cgi->param('nolimit');
        my $page = $cgi->param('page') || 1;
                my $page = $cgi->param('page') || 0;
    grep -- '\$query->param' opac/opac-sendbasket.pl
        my $bib_list     = $query->param('bib_list');
        my $email_add    = $query->param('email_add');
        my $email_sender = $query->param('email_sender');
            my $comment    = $query->param('comment');
    grep -- '\$query->param' opac/opac-sendshelf.pl
        my $shelfid = $query->param('shelfid');
        my $email   = $query->param('email');
            my $comment    = $query->param('comment');
    grep -- '\$query->param' opac/opac-serial-issues.pl
        my $op         = $query->param('op');
        my $selectview = $query->param('selectview');
        my $biblionumber = $query->param('biblionumber');
                biblionumber   => $query->param('biblionumber'),
                biblionumber      => $query->param('biblionumber'),
    grep -- '\$query->param' opac/opac-shareshelf.pl
            $param->{shelfnumber} = $query->param('shelfnumber') || 0;
            $param->{op}          = $query->param('op') || '';
            $param->{addrlist}    = $query->param('invite_address') || '';
            $param->{key}         = $query->param('key') || '';
    grep -- '\$input->param' opac/opac-showmarc.pl
        my $biblionumber = $input->param('id');
        my $importid= $input->param('importid');
        my $view= $input->param('viewas') || 'marc';
    grep -- '\$query->param' opac/opac-showreviews.pl
        my $format = $query->param("format") || '';
        my $results_per_page = $query->param('count') || $count;
        my $offset = $query->param('offset') || 0;
        my $page = $query->param('page') || 1;
    grep -- '\$input->param' opac/opac-suggestions.pl
        my $allsuggestions  = $input->param('showall');
        my $op              = $input->param('op');
        my $negcaptcha      = $input->param('negcap');
        my $deleted = $input->param('deleted');
        my $submitted = $input->param('submitted');
                $suggestion->{branchcode} = $input->param('branchcode') || C4::Context->userenv->{"branch"};
            my @delete_field = $input->param("delete_field");
            my $branchcode = $input->param('branchcode') || $borr->{'branchcode'} || $userbranch || '' ;
    grep -- '\$query->param' opac/opac-tags_subject.pl
        my $number = $query->param('number') || 100;
    grep -- '\$input->param' opac/opac-topissues.pl
        my $do_it = $input->param('do_it') || 0; # as form been posted
        my $limit = $input->param('limit');
        my $branch = $input->param('branch') || '';
        my $itemtype = $input->param('itemtype') || '';
        my $timeLimit = $input->param('timeLimit') || 3;
    grep -- '\$query->param' opac/opac-user.pl
        my %renewed = map { $_ => 1 } split( ':', $query->param('renewed') );
        my $patronupdate = $query->param('patronupdate');
        my $renew_error = $query->param('renew_error');
    grep -- '\$input->param' opac/sco/printslip.pl
        my $print = $input->param('print');
        my $error = $input->param('error');
        my $borrowernumber = $input->param('borrowernumber');
    grep -- '\$query->param' opac/sco/sco-main.pl
            $query->param(-name=>'userid',-values=>[$AutoSelfCheckID]);
            $query->param(-name=>'password',-values=>[$AutoSelfCheckPass]);
            $query->param(-name=>'koha_login_context',-values=>['sco']);
            $query->param("op")         || '',
            $query->param("patronid")   || '',
            $query->param("patronlogin")|| '',
            $query->param("patronpw")   || '',
            $query->param("barcode")    || '',
            $query->param("confirmed")  || '',
            $query->param( patronid => undef, patronlogin => undef, patronpw => undef );
    grep -- '\$cgi->param' opac/svc/shelfbrowser.pl
            my $starting_itemnumber = $cgi->param('shelfbrowse_itemnumber');
    grep -- '\$cgi->param' opac/tracklinks.pl
        my $uri = $cgi->param('uri') || '';
                my $biblionumber = $cgi->param('biblionumber') || 0;
                my $itemnumber   = $cgi->param('itemnumber')   || 0;
    grep -- '\$cgi->param' patron_lists/add-modify.pl
        my $id   = $cgi->param('patron_list_id');
        my $name = $cgi->param('name');
    grep -- '\$cgi->param' patron_lists/delete.pl
        my $id = $cgi->param('patron_list_id');
    grep -- '\$cgi->param' patron_lists/list.pl
          GetPatronLists( { patron_list_id => $cgi->param('patron_list_id') } );
        my @patrons_to_add = $cgi->param('patrons_to_add');
        my @patrons_to_remove = $cgi->param('patrons_to_remove');
    grep -- '\$cgi->param' patron_lists/patrons.pl
        my $id   = $cgi->param('patron_list_id');
        my $name = $cgi->param('name');
    grep -- '\$cgi->param' patroncards/card-print.pl
        my $op = $cgi->param('op') || 'none';
        my @label_ids = $cgi->param('label_id') if $cgi->param('label_id');   # this will handle individual label printing
        my @batch_ids = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $layout_id = $cgi->param('layout_id') || undef;
        my $template_id = $cgi->param('template_id') || undef;
        my $start_label = $cgi->param('start_label') || 1;
        my @item_numbers = $cgi->param('item_number') if $cgi->param('item_number');
        my $output_format = $cgi->param('output_format') || 'pdf';
        my $referer = $cgi->param('referer') || undef;
    grep -- '\$cgi->param' patroncards/create-pdf.pl
        my $batch_id    = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $template_id = $cgi->param('template_id') || undef;
        my $layout_id   = $cgi->param('layout_id') || undef;
        my $start_label = $cgi->param('start_label') || 1;
        my @label_ids   = $cgi->param('label_id') if $cgi->param('label_id');
        my @borrower_numbers  = $cgi->param('borrower_number') if $cgi->param('borrower_number');
    grep -- '\$cgi->param' patroncards/edit-batch.pl
        my $op = $cgi->param('op') || 'new';
        my $batch_id = $cgi->param('element_id') || $cgi->param('batch_id') || undef;
        my @label_ids = $cgi->param('label_id') if $cgi->param('label_id');
        my @item_numbers = $cgi->param('item_number') if $cgi->param('item_number');
        my @borrower_numbers = $cgi->param('borrower_number') if $cgi->param('borrower_number');
        my $errstr = $cgi->param('error') || '';
    grep -- '\$cgi->param' patroncards/edit-layout.pl
        my $op = $cgi->param('op') || 'new'; # make 'new' the default operation if none is submitted
        my $layout_id = $cgi->param('layout_id') || $cgi->param('element_id') || '';
        my $layout_choice = $cgi->param('layout_choice') || '';
            foreach my $parameter ($cgi->param()) {     # parse the field values and build a hash of the layout for conversion to xml and storage in the db
                        push @$text_lines, $cgi->param($parameter);
                        $text_lines->[$array_index]->{$field_data} = $cgi->param($parameter);
                    $layout->{'barcode'}->{$1} = $cgi->param($parameter);
                    $field_enabled = $image_number if $cgi->param("image_$image_number" . "_image_source") ne 'none';
                        $layout->{'images'}->{"image_$image_number"}->{'data_source'}->{"image_$1"} = $cgi->param($parameter);
                        $layout->{'images'}->{"image_$image_number"}->{$image_data} = $cgi->param($parameter);
                    $layout_name = $cgi->param($parameter) if $parameter eq 'layout_name';
                    $layout_id = $cgi->param($parameter) if $parameter eq 'layout_id';
                    $layout->{'units'} = $cgi->param($parameter) if $parameter eq 'units';
                    $layout->{'page_side'} = $cgi->param($parameter) if $parameter eq 'page_side';
                    $layout->{'guide_box'} = $cgi->param($parameter) if $parameter eq 'guide_box';
    grep -- '\$cgi->param' patroncards/edit-profile.pl
        my $op = $cgi->param('op') || '';
        my $profile_id = $cgi->param('profile_id') || $cgi->param('element_id');
                printer_name        => $cgi->param('printer_name'),
                paper_bin           => $cgi->param('paper_bin'),
                offset_horz         => $cgi->param('offset_horz'),
                offset_vert         => $cgi->param('offset_vert'),
                creep_horz          => $cgi->param('creep_horz'),
                creep_vert          => $cgi->param('creep_vert'),
                units               => $cgi->param('units'),
    grep -- '\$cgi->param' patroncards/edit-template.pl
        my $op = $cgi->param('op') || '';
        my $template_id = $cgi->param('template_id') || $cgi->param('element_id');
            my @params = (      profile_id      => $cgi->param('profile_id') || '',
                                template_code   => $cgi->param('template_code'),
                                template_desc   => $cgi->param('template_desc'),
                                page_width      => $cgi->param('page_width'),
                                page_height     => $cgi->param('page_height'),
                                label_width     => $cgi->param('card_width'),
                                label_height    => $cgi->param('card_height'),
                                top_margin      => $cgi->param('top_margin'),
                                left_margin     => $cgi->param('left_margin'),
                                cols            => $cgi->param('cols'),
                                rows            => $cgi->param('rows'),
                                col_gap         => $cgi->param('col_gap'),
                                row_gap         => $cgi->param('row_gap'),
                                units           => $cgi->param('units'),
                if ($cgi->param('profile_id') && ($card_template->get_attr('template_id') != $cgi->param('profile_id'))) {
                    my $new_profile = C4::Patroncards::Profile->retrieve(profile_id => $cgi->param('profile_id'));
                if ($cgi->param('profile_id')) {
                    my $profile = C4::Patroncards::Profile->retrieve(profile_id => $cgi->param('profile_id'));
    grep -- '\$cgi->param' patroncards/manage.pl
        my $op = $cgi->param('op') || 'none';
        my $card_element = $cgi->param('card_element') || 'template';   # default to template managment
        my $element_id = $cgi->param('element_id') || 0; # there should never be an element with a id of 0 so this is a safe default
        my $errstr = ($cgi->param('error') ? $cgi->param('error') : '');
    grep -- '\$cgi->param' patroncards/print.pl
        my $op = $cgi->param('op') || 'none';
        my @label_ids = $cgi->param('label_id') if $cgi->param('label_id');   # this will handle individual card printing; we use label_id to maintain consistency with the column names in the creator_batches table
        my @batch_ids = $cgi->param('batch_id') if $cgi->param('batch_id');
        my $layout_id = $cgi->param('layout_id') || undef;
        my $template_id = $cgi->param('template_id') || undef;
        my $start_card = $cgi->param('start_card') || 1;
        my @borrower_numbers = $cgi->param('borrower_number') if $cgi->param('borrower_number');
        my $output_format = $cgi->param('output_format') || 'pdf';
        my $referer = $cgi->param('referer') || undef;
    grep -- '\$input->param' plugins/plugins-home.pl
        my $method = $input->param('method');
    grep -- '\$input->param' plugins/plugins-uninstall.pl
        my $class = $input->param('class');
    grep -- '\$input->param' plugins/plugins-upload.pl
        my $uploadfilename = $input->param('uploadfile');
        my $op             = $input->param('op');
    grep -- '\$cgi->param' plugins/run.pl
        my $class  = $cgi->param('class');
        my $method = $cgi->param('method');
    grep -- '\$input->param' reports/acquisitions_stats.pl
        my $do_it          = $input->param('do_it');
        my $line           = $input->param("Line");
        my $column         = $input->param("Column");
        my @filters        = $input->param("Filter");
        my $podsp          = $input->param("PlacedOnDisplay");
        my $rodsp          = $input->param("ReceivedOnDisplay");
        my $calc           = $input->param("Cellvalue");
        my $output         = $input->param("output");
        my $basename       = $input->param("basename");
        our $sep     = $input->param("sep") // '';
    grep -- '\$input->param' reports/bor_issues_top.pl
        my $do_it   = $input->param('do_it');
        my $limit   = $input->param("Limit");
        my $column  = $input->param("Criteria");
        my @filters = $input->param("Filter");
        my $output   = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep");
    grep -- '\$input->param' reports/borrowers_out.pl
        my $do_it=$input->param('do_it');
        my $limit = $input->param("Limit");
        my $column = $input->param("Criteria");
        my @filters = $input->param("Filter");
        my $output = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep") || '';
    grep -- '\$input->param' reports/borrowers_stats.pl
        my $do_it=$input->param('do_it');
        my $line = $input->param("Line");
        my $column = $input->param("Column");
        my @filters = $input->param("Filter");
        my $digits = $input->param("digits");
        our $period = $input->param("period");
        my $borstat = $input->param("status");
        my $borstat1 = $input->param("activity");
        my $output = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep");
        my $selected_branch; # = $input->param("?");
            my @params_names = $input->param;
                    my $value = $input->param($name);
    grep -- '\$input->param' reports/cat_issues_top.pl
        my $do_it=$input->param('do_it');
        my $limit = $input->param("Limit");
        my $column = $input->param("Criteria");
        my @filters = $input->param("Filter");
        my $output = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep");
    grep -- '\$input->param' reports/catalogue_out.pl
        my $do_it   = $input->param('do_it');
        my $limit   = $input->param("Limit") || 10;
        my $column  = $input->param("Criteria");
        my @filters = $input->param("Filter");
    grep -- '\$input->param' reports/catalogue_stats.pl
        my $do_it       = $input->param('do_it');
        my $line        = $input->param("Line");
        my $column      = $input->param("Column");
        my @filters     = $input->param("Filter");
        my $deweydigits = $input->param("deweydigits");
        my $lccndigits  = $input->param("lccndigits");
        my $cotedigits  = $input->param("cotedigits");
        my $output      = $input->param("output");
        my $basename    = $input->param("basename");
        our $sep        = $input->param("sep");
    grep -- '\$input->param' reports/dictionary.pl
        my $phase = $input->param('phase') || 'View Dictionary';
        my $definition_name        = $input->param('definition_name');
        my $definition_description = $input->param('definition_description');
        my $area  = $input->param('area') || '';
            my @columns                = $input->param('columns');
            my $columnstring           = $input->param('columnstring');
            my @criteria               = $input->param('criteria_column');
                my $value = $input->param( $crit . "_value" );
                $value = $input->param( $crit . "_start_value" );
                $value = $input->param( $crit . "_end_value" );
            my $area                   = $input->param('area');
            my $sql                    = $input->param('sql');
            my $id = $input->param('id');
    grep -- '\$input->param' reports/guided_reports.pl
        my $phase = $input->param('phase');
        if ( $input->param("filter_set") ) {
            $filter->{$_} = $input->param("filter_$_") foreach qw/date author keyword group subgroup/;
            my $group = $input->param('group');
            my $subgroup = $input->param('subgroup');
            my @ids = $input->param('ids');
            my $ids = $input->param('reports');
            my $id = $input->param('reports');
            my $id = $input->param('reports');
            my $id         = $input->param('id');
            my $sql        = $input->param('sql');
            my $reportname = $input->param('reportname');
            my $group      = $input->param('group');
            my $subgroup   = $input->param('subgroup');
            my $notes      = $input->param('notes');
            my $cache_expiry = $input->param('cache_expiry');
            my $cache_expiry_units = $input->param('cache_expiry_units');
            my $public = $input->param('public');
            my $save_anyway = $input->param('save_anyway');
            my $id = $input->param('id');
            my $cache_expiry_units = $input->param('cache_expiry_units'),
            my $cache_expiry = $input->param('cache_expiry');
                'public' => $input->param('public'),
                  'area'   => $input->param('area'),
                  'public' => $input->param('public'),
            my $area = $input->param('area');
            my $type = $input->param('types');
                'cache_expiry' => $input->param('cache_expiry'),
                'public' => $input->param('public'),
            my $area    = $input->param('area');
            my $type    = $input->param('type');
            my @columns = $input->param('columns');
                'cache_expiry' => $input->param('cache_expiry'),
                'cache_expiry_units' => $input->param('cache_expiry_units'),
                'public' => $input->param('public'),
            my $area     = $input->param('area');
            my $type     = $input->param('type');
            my $column   = $input->param('column');
            my @definitions = $input->param('definition');
            my @criteria = $input->param('criteria_column');
                my $value = $input->param( $crit . "_value" );
                    my $fromvalue = $input->param( "from_" . $crit . "_value" );
                    my $tovalue   = $input->param( "to_"   . $crit . "_value" );
                'cache_expiry' => $input->param('cache_expiry'),
                'cache_expiry_units' => $input->param('cache_expiry_units'),
                'public' => $input->param('public'),
            my $area     = $input->param('area');
            my $type     = $input->param('type');
            my $column   = $input->param('column');
            my $criteria = $input->param('criteria');
            my $definition = $input->param('definition');
            my @total_by = $input->param('total_by');
                my $value = $input->param( $total . "_tvalue" );
                'cache_expiry' => $input->param('cache_expiry'),
                'public' => $input->param('public'),
            my $area     = $input->param('area');
            my $type     = $input->param('type');
            my $column   = $input->param('column');
            my $crit     = $input->param('criteria');
            my $totals   = $input->param('totals');
            my $definition = $input->param('definition');
            my @order_by = $input->param('order_by');
                my $value = $input->param( $order . "_ovalue" );
                'cache_expiry' => $input->param('cache_expiry'),
                'public' => $input->param('public'),
            my $area           = $input->param('area');
            my $sql  = $input->param('sql');
            my $type = $input->param('type');
                'cache_expiry' => $input->param('cache_expiry'),
                'public' => $input->param('public'),
            my $area  = $input->param('area');
            my $group = $input->param('group');
            my $subgroup = $input->param('subgroup');
            my $sql   = $input->param('sql');
            my $name  = $input->param('reportname');
            my $type  = $input->param('types');
            my $notes = $input->param('notes');
            my $cache_expiry = $input->param('cache_expiry');
            my $cache_expiry_units = $input->param('cache_expiry_units');
            my $public = $input->param('public');
            my $save_anyway = $input->param('save_anyway');
            my $limit      = $input->param('limit') || 20;
            my $report_id  = $input->param('reports');
            my @sql_params = $input->param('sql_params');
            if ($input->param('page')) {
                $offset = ($input->param('page') - 1) * $limit;
                        'pagination_bar'  => pagination_bar($url, $totpages, $input->param('page')),
            my $sql    = $input->param('sql');  # FIXME: use sql from saved report ID#, not new user-supplied SQL!
            my $format = $input->param('format');
            if ( $input->param('sql') ) {
                $group = $input->param('report_group');
                $subgroup  = $input->param('report_subgroup');
                    'sql'           => $input->param('sql') // '',
                    'reportname'    => $input->param('reportname') // '',
                    'notes'         => $input->param('notes') // '',
            my $master    = $input->param('master');
            my $subreport = $input->param('subreport');
                    my $groupdesc = $input->param('groupdesc') // $group;
                        my $subgroupdesc = $input->param('subgroupdesc') // $subgroup;
    grep -- '\$input->param' reports/issues_avg_stats.pl
        my $do_it=$input->param('do_it');
        my $line = $input->param("Line");
        my $column = $input->param("Column");
        my @filters = $input->param("Filter");
        my $podsp = $input->param("IssueDisplay");
        my $rodsp = $input->param("ReturnDisplay");
        my $calc = $input->param("Cellvalue");
        my $output = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep");
    grep -- '\$input->param' reports/issues_stats.pl
        my $do_it    = $input->param('do_it');
        my $line     = $input->param("Line");
        my $column   = $input->param("Column");
        my @filters  = $input->param("Filter");
        my $podsp    = $input->param("DisplayBy");
        my $type     = $input->param("PeriodTypeSel");
        my $daysel   = $input->param("PeriodDaySel");
        my $monthsel = $input->param("PeriodMonthSel");
        my $calc     = $input->param("Cellvalue");
        my $output   = $input->param("output");
        my $basename = $input->param("basename");
        our $sep     = $input->param("sep");
    grep -- '\$input->param' reports/manager.pl
        my $report_name=$input->param("report_name");
        my $do_it=$input->param('do_it');
        my @values = $input->param("value");
    grep -- '\$input->param' reports/reservereport.pl
        my $time  = $input->param('time');
        my $branch = $input->param('branch');
        my $sort = $input->param('sort');
    grep -- '\$input->param' reports/reserves_stats.pl
        my $do_it    = $input->param('do_it');
        my $line     = $input->param("Line");
        my $column   = $input->param("Column");
        my $podsp    = $input->param("DisplayBy");
        my $type     = $input->param("PeriodTypeSel");
        my $daysel   = $input->param("PeriodDaySel");
        my $monthsel = $input->param("PeriodMonthSel");
        my $calc     = $input->param("Cellvalue");
        my $output   = $input->param("output");
        my $basename = $input->param("basename");
        my $mime     = $input->param("MIME");
        our $sep     = $input->param("sep") || '';
    grep -- '\$input->param' reports/serials_stats.pl
        my $do_it      = $input->param("do_it");
        my $bookseller = $input->param("bookseller");
        my $branchcode = $input->param("branchcode");
        my $expired    = $input->param("expired");
        my $order      = $input->param("order");
        my $output     = $input->param("output");
        my $basename   = $input->param("basename");
        our $sep       = $input->param("sep") || '';
    grep -- '\$input->param' reports/stats.print.pl
        my $time=$input->param('time');
        my $time2=$input->param('time2');
    grep -- '\$input->param' reports/stats.screen.pl
        my $time  = $input->param('time');
        my $time2 = $input->param('time2');
        my $op    = $input->param('submit');
    grep -- '\$query->param' reserve/modrequest.pl
        my @reserve_id = $query->param('reserve_id');
        my @rank = $query->param('rank-request');
        my @biblionumber = $query->param('biblionumber');
        my @borrower = $query->param('borrowernumber');
        my @branch = $query->param('pickup');
        my @itemnumber = $query->param('itemnumber');
        my @suspend_until=$query->param('suspend_until');
        my $multi_hold = $query->param('multi_hold');
        my $biblionumbers = $query->param('biblionumbers');
        my $CancelBiblioNumber = $query->param('CancelBiblioNumber');
        my $CancelBorrowerNumber = $query->param('CancelBorrowerNumber');
        my $CancelItemnumber = $query->param('CancelItemnumber');
        my $from=$query->param('from');
    grep -- '\$query->param' reserve/modrequest_suspendall.pl
        my $borrowernumber = $query->param('borrowernumber');
        my $suspend        = $query->param('suspend');
        my $suspend_until  = $query->param('suspend_until');
        my $from = $query->param('from');
    grep -- '\$input->param' reserve/renewscript.pl
        if ( $input->param('renew_all') ) {
            @data = $input->param('all_items[]');
            @data = $input->param('items[]');
        if ( $input->param('return_all') ) {
            @barcodes = $input->param('all_barcodes[]');
            @barcodes = $input->param('barcodes[]');
        my $branch = $input->param('branch');
        if ( $input->param('newduedate') ) {
            $datedue = dt_from_string( $input->param('newduedate') );
        my $cardnumber     = $input->param("cardnumber");
        my $borrowernumber = $input->param("borrowernumber");
        my $exemptfine     = $input->param("exemptfine") || 0;
        my $override_limit = $input->param("override_limit") || 0;
        if ( $input->param('destination') eq "circ" ) {
    grep -- '\$input->param' reserve/request.pl
        my $multihold = $input->param('multi_hold');
        my $showallitems = $input->param('showallitems');
        my $findborrower = $input->param('findborrower');
        my $borrowernumber_hold = $input->param('borrowernumber') || '';
        my $action = $input->param('action');
          my $where = $input->param('where');
          my $reserve_id = $input->param('reserve_id');
          my $reserve_id = $input->param('reserve_id');
          my $reserve_id = $input->param('reserve_id');
          my $reserve_id = $input->param('reserve_id');
          my $suspend_until  = $input->param('suspend_until');
        my $biblionumbers = $input->param('biblionumbers');
            push @biblionumbers, $input->param('biblionumber');
    grep -- '\$query->param' reviews/reviewswaiting.pl
        my $op       = $query->param('op') || '';
        my $status   = $query->param('status') || 0;
        my $reviewid = $query->param('reviewid');
        my $offset   = $query->param('offset') || 0;
    grep -- '\$query->param' rotating_collections/addItems.pl
        if ( $query->param('action') eq 'addItem' ) {
            my $colId      = $query->param('colId');
            my $barcode    = $query->param('barcode');
            my $removeItem = $query->param('removeItem');
          GetCollection( $query->param('colId') );
    grep -- '\$query->param' rotating_collections/editCollections.pl
        my $action = $query->param('action');
            my $title       = $query->param('title');
            my $description = $query->param('description');
            my $colId = $query->param('colId');
            my ( $colId, $colTitle, $colDesc, $colBranchcode ) = GetCollection( $query->param('colId') );
            my $colId       = $query->param('colId');
            my $title       = $query->param('title');
            my $description = $query->param('description');
    grep -- '\$query->param' rotating_collections/transferCollection.pl
        my $colId    = $query->param('colId');
        my $toBranch = $query->param('toBranch');
    grep -- '\$query->param' serials/acqui-search-result.pl
        my $supplier=$query->param('supplier');
    grep -- '\$query->param' serials/checkexpiration.pl
        my $title = $query->param('title');
        my $issn  = $query->param('issn');
        my $date  = format_date_in_iso($query->param('date'));
    grep -- '\$input->param' serials/create-numberpattern.pl
            $numberpattern->{$_} = $input->param($_);
        $numberpattern->{'label'} = $input->param('patternname');
    grep -- '\$query->param' serials/lateissues-export.pl
        my $supplierid = $query->param('supplierid');
        my @serialids = $query->param('serialid');
        my $op = $query->param('op') || q{};
        my $csv_profile_id = $query->param('csv_profile');
    grep -- '\$cgi->param' serials/member-search.pl
        my $theme = $cgi->param('theme') || "default";
        my $resultsperpage = $cgi->param('resultsperpage')||C4::Context->preference("PatronsPerPage")||20;
        my $startfrom = $cgi->param('startfrom')||1;
        my $subscriptionid = $cgi->param('subscriptionid');
        my $searchstring   = $cgi->param('member');
        my $member=$cgi->param('member');
        my $orderby=$cgi->param('orderby');
    grep -- '\$query->param' serials/routing-preview.pl
        my $subscriptionid = $query->param('subscriptionid');
        my $issue = $query->param('issue');
        my $ok = $query->param('ok');
        my $edit = $query->param('edit');
        my $delete = $query->param('delete');
    grep -- '\$query->param' serials/routing.pl
        my $subscriptionid = $query->param('subscriptionid');
        my $serialseq = $query->param('serialseq');
        my $routingid = $query->param('routingid');
        my $borrowernumber = $query->param('borrowernumber');
        my $notes = $query->param('notes');
        my $op = $query->param('op') || q{};
        my $date_selected = $query->param('date_selected');
    grep -- '\$query->param' serials/serial-issues.pl
        my $selectview = $query->param('selectview');
        my $biblionumber = $query->param('biblionumber');
                biblionumber => $query->param('biblionumber'),
                biblionumber => "".$query->param('biblionumber'),
    grep -- '\$query->param' serials/serials-collection.pl
        my $op = $query->param('op') || q{};
        my $nbissues=$query->param('nbissues');
        my $biblionumber = $query->param('biblionumber');
        my @subscriptionid = $query->param('subscriptionid');
                  subscr=>$query->param('subscriptionid'),
    grep -- '\$query->param' serials/serials-home.pl
        my $routing = $query->param('routing') || C4::Context->preference("RoutingSerials");
    grep -- '\$query->param' serials/serials-recieve.pl
        my $op = $query->param('op') || q{};
        my $subscriptionid = $query->param('subscriptionid');
        # my $auser = $query->param('user');
        my $histstartdate = format_date_in_iso($query->param('histstartdate'));
        my $enddate = format_date_in_iso($query->param('enddate'));
        my $recievedlist = $query->param('recievedlist');
        my $missinglist = $query->param('missinglist');
        my $opacnote = $query->param('opacnote');
        my $librariannote = $query->param('librariannote');
        my @serialids = $query->param('serialid');
        my @serialseqs = $query->param('serialseq');
        my @planneddates = $query->param('planneddate');
        my @publisheddates = $query->param('publisheddate');
        my @status = $query->param('status');
        my @notes = $query->param('notes');
        my @barcodes = $query->param('barcode');
        my @itemcallnumbers = $query->param('itemcallnumber');
        my @locations = $query->param('location');
        my @itemstatus = $query->param('itemstatus');
        my @homebranches = $query->param('branch');
            $manualdate = $query->param('planneddate');
            $manualissue = $query->param('missingissue');
    grep -- '\$query->param' serials/serials-search.pl
        my $title         = $query->param('title_filter') || '';
        my $ISSN          = $query->param('ISSN_filter') || '';
        my $EAN           = $query->param('EAN_filter') || '';
        my $callnumber    = $query->param('callnumber_filter') || '';
        my $publisher     = $query->param('publisher_filter') || '';
        my $bookseller    = $query->param('bookseller_filter') || '';
        my $biblionumber  = $query->param('biblionumber') || '';
        my $branch        = $query->param('branch_filter') || '';
        my $location      = $query->param('location_filter') || '';
        my $expiration_date = $query->param('expiration_date_filter') || '';
        my $routing       = $query->param('routing') || C4::Context->preference("RoutingSerials");
        my $searched      = $query->param('searched') || 0;
        my $op            = $query->param('op');
    grep -- '\$input->param' serials/showpredictionpattern.pl
        my $subscriptionid = $input->param('subscriptionid');
        my $frequencyid = $input->param('frequency');
        my $firstacquidate = $input->param('firstacquidate');
        my $nextacquidate = $input->param('nextacquidate');
        my $enddate = $input->param('enddate');
        my $subtype = $input->param('subtype');
        my $sublength = $input->param('sublength');
        my $custompattern = $input->param('custompattern');
            numberingmethod => $input->param('numberingmethod') // '',
            numbering1      => $input->param('numbering1') // '',
            numbering2      => $input->param('numbering2') // '',
            numbering3      => $input->param('numbering3') // '',
            add1            => $input->param('add1') // '',
            add2            => $input->param('add2') // '',
            add3            => $input->param('add3') // '',
            whenmorethan1   => $input->param('whenmorethan1') // '',
            whenmorethan2   => $input->param('whenmorethan2') // '',
            whenmorethan3   => $input->param('whenmorethan3') // '',
            setto1          => $input->param('setto1') // '',
            setto2          => $input->param('setto2') // '',
            setto3          => $input->param('setto3') // '',
            every1          => $input->param('every1') // '',
            every2          => $input->param('every2') // '',
            every3          => $input->param('every3') // '',
            locale      => $input->param('locale') // '',
            lastvalue1      => $input->param('lastvalue1') // '',
            lastvalue2      => $input->param('lastvalue2') // '',
            lastvalue3      => $input->param('lastvalue3') // '',
            innerloop1      => $input->param('innerloop1') // '',
            innerloop2      => $input->param('innerloop2') // '',
            innerloop3      => $input->param('innerloop3') // '',
    grep -- '\$input->param' serials/subscription-bib-search.pl
        my $op = $input->param('op') || q{};
        my $startfrom = $input->param('startfrom');
        my $query = $input->param('q');
            my $itemtypelimit = $input->param('itemtypelimit');
            my $ccodelimit    = $input->param('ccodelimit');
            $resultsperpage = $input->param('resultsperpage');
    grep -- '\$query->param' serials/subscription-detail.pl
        my $op = $query->param('op') || q{};
        my $issueconfirmed = $query->param('issueconfirmed');
        my $subscriptionid = $query->param('subscriptionid');
    grep -- '\$input->param' serials/subscription-frequencies.pl
        my $op = $input->param('op');
                my $frequencyid = $input->param('frequencyid');
                $frequency->{$_} = $input->param($_);
                $frequency->{id} = $input->param('id');
            my $frequencyid = $input->param('frequencyid');
                my $confirm = $input->param('confirm');
    grep -- '\$input->param' serials/subscription-frequency.pl
        my $frqid=$input->param("frequency_id");
    grep -- '\$input->param' serials/subscription-history.pl
        my $subscriptionid  = $input->param('subscriptionid');
        my $op              = $input->param('op');
            my $histstartdate   = $input->param('histstartdate');
            my $histenddate     = $input->param('histenddate');
            my $receivedlist    = $input->param('receivedlist');
            my $missinglist     = $input->param('missinglist');
            my $opacnote        = $input->param('opacnote');
            my $librariannote   = $input->param('librariannote');
    grep -- '\$input->param' serials/subscription-numberpattern.pl
        my $numpatternid=$input->param("numberpattern_id");
    grep -- '\$input->param' serials/subscription-numberpatterns.pl
        my $op = $input->param('op');
            my $label = $input->param('label');
                $numberpattern->{$_} = $input->param($_);
            my $id = $input->param('id');
            my $label = $input->param('label');
                    $numberpattern->{$_} = $input->param($_) || undef;
                my $id = $input->param('id');
            my $id = $input->param('id');
                my $confirm = $input->param('confirm');
    grep -- '\$query->param' serials/subscription-renew.pl
        my $mode           = $query->param('mode') || q{};
        my $op             = $query->param('op') || 'display';
        my $subscriptionid = $query->param('subscriptionid');
                C4::Dates->new($query->param('startdate'))->output('iso'),  $query->param('numberlength'),
                $query->param('weeklength'), $query->param('monthlength'),
                $query->param('note')
    grep -- '\$input->param' serials/viewalerts.pl
        my $print = $input->param('print');
        my $subscriptionid=$input->param('subscriptionid');
    grep -- '\$input->param' services/itemrecorddisplay.pl
        my $biblionumber = $input->param('biblionumber') || '';
        my $itemnumber = $input->param('itemnumber') || '';
        my $frameworkcode = $input->param('frameworkcode') || '';
    grep -- '\$query->param' sms/sms.pl
        my $message   = $query->param( 'message' );
        my $phone     = $query->param(  'phone'  );
        my $operation = $query->param('operation');
    grep -- '\$input->param' test/progressbarsubmit.pl
        my $submitted=$input->param('submitted');
        my $runinbackground = $input->param('runinbackground');
        my $jobID = $input->param('jobID');
        my $completedJobID = $input->param('completedJobID');
    grep -- '\$input->param' tools/ajax-inventory.pl
        my $seen = $input->param('seen');
    grep -- '\$input->param' tools/background-job-progress.pl
        my $jobID = $input->param('jobID');
    grep -- '\$input->param' tools/batchMod.pl
        my $error        = $input->param('error');
        my @itemnumbers  = $input->param('itemnumber');
        my $biblionumber = $input->param('biblionumber');
        my $op           = $input->param('op');
        my $del          = $input->param('del');
        my $del_records  = $input->param('del_records');
        my $completedJobID = $input->param('completedJobID');
        my $runinbackground = $input->param('runinbackground');
        my $src          = $input->param('src');
        my $use_default_values = $input->param('use_default_values');
            my @tags      = $input->param('tag');
            my @subfields = $input->param('subfield');
            my @values    = $input->param('field_value');
            my @disabled  = $input->param('disable_input');
            my @ind_tag   = $input->param('ind_tag');
            my @indicator = $input->param('indicator');
            my $filecontent = $input->param('filecontent');
                if ( my $list=$input->param('barcodelist')){
    grep -- '\$input->param' tools/batch_delete_records.pl
        my $op = $input->param('op') // q|form|;
        my $recordtype = $input->param('recordtype') // 'biblio';
            if ( my $bib_list = $input->param('bib_list') ) {
            } elsif ( my $uploadfile = $input->param('uploadfile') ) {
                push @record_ids, split( /\s\n/, $input->param('recordnumber_list') );
            my @record_ids = $input->param('record_id');
    grep -- '\$input->param' tools/batch_records_ajax.pl
        my $import_batch_id   = $input->param('import_batch_id');
        my $offset            = $input->param('iDisplayStart');
        my $results_per_page  = $input->param('iDisplayLength');
        my $sorting_column    = $sort_columns[ $input->param('iSortCol_0') ];
        my $sorting_direction = $input->param('sSortDir_0');
        $data->{'sEcho'}                = $input->param('sEcho') || undef;
    grep -- '\$input->param' tools/copy-holidays.pl
        my $branchcode          = $input->param('branchcode');
        my $from_branchcode     = $input->param('from_branchcode');
    grep -- '\$input->param' tools/csv-profiles.pl
        my $profile_name        = $input->param("profile_name");
        my $profile_description = $input->param("profile_description");
        my $csv_separator       = $input->param("csv_separator");
        my $field_separator     = $input->param("field_separator");
        my $subfield_separator  = $input->param("subfield_separator");
        my $encoding            = $input->param("encoding");
        my $type                = $input->param("profile_type");
        my $action              = $input->param("action");
        my $delete              = $input->param("delete");
        my $id                  = $input->param("id");
            ? $input->param("profile_marc_content")
            : $input->param("profile_sql_content");
    grep -- '\$input->param' tools/exceptionHolidays.pl
        my $branchcode = $input->param('showBranchName');
        my $weekday = $input->param('showWeekday');
        my $day = $input->param('showDay');
        my $month = $input->param('showMonth');
        my $year = $input->param('showYear');
        my $title = $input->param('showTitle');
        my $description = $input->param('showDescription');
        my $holidaytype = $input->param('showHolidayType');
        my $datecancelrange = $input->param('datecancelrange');
        if ($input->param('showOperation') eq 'exception') {
        } elsif ($input->param('showOperation') eq 'exceptionrange' ) {
        } elsif ($input->param('showOperation') eq 'edit') {
        } elsif ($input->param('showOperation') eq 'delete') {
        }elsif ($input->param('showOperation') eq 'deleterange') {
        }elsif ($input->param('showOperation') eq 'deleterangerepeat') {
        }elsif ($input->param('showOperation') eq 'deleterangerepeatexcept') {
    grep -- '\$query->param' tools/export.pl
        my $op       = $query->param("op")       || '';
        my $filename = $query->param("filename") || 'koha.mrc';
        my $output_format = $query->param("format") || $query->param("output_format") || 'iso2709';
            $op       = $query->param("op")       || '';
            $filename = $query->param("filename") || 'koha.mrc';
        my @branch = $query->param("branch");
                $record_type = $query->param("record_type") unless ($commandline);
                my $export_remove_fields = $query->param("export_remove_fields");
                my @biblionumbers      = $query->param("biblionumbers");
                my @itemnumbers        = $query->param("itemnumbers");
                my $StartingBiblionumber = $query->param("StartingBiblionumber");
                my $EndingBiblionumber   = $query->param("EndingBiblionumber");
                my $itemtype             = $query->param("itemtype");
                my $start_callnumber     = $query->param("start_callnumber");
                my $end_callnumber       = $query->param("end_callnumber");
                  ( $query->param("start_accession") )
                  ? C4::Dates->new( $query->param("start_accession") )
                  ( $query->param("end_accession") )
                  ? C4::Dates->new( $query->param("end_accession") )
                $dont_export_items = $query->param("dont_export_item")
                my $strip_nonlocal_items = $query->param("strip_nonlocal_items");
                my $starting_authid = $query->param('starting_authid');
                my $ending_authid   = $query->param('ending_authid');
                my $authtype        = $query->param('authtype');
                my @biblionumbers = uniq $query->param("biblionumbers");
                my @itemnumbers   = $query->param("itemnumbers");
    grep -- '\$input->param' tools/holidays.pl
        my $calendarinput = C4::Dates->new($input->param('calendardate')) || $today;
        my $branch= $input->param('branch') || C4::Context->userenv->{'branch'};
    grep -- '\$cgi->param' tools/koha-news.pl
        my $id             = $cgi->param('id');
        my $title          = $cgi->param('title');
        my $new            = $cgi->param('new');
        my $expirationdate = format_date_in_iso($cgi->param('expirationdate'));
        my $timestamp      = format_date_in_iso($cgi->param('timestamp'));
        my $number         = $cgi->param('number');
        my $lang           = $cgi->param('lang');
        my $branchcode     = $cgi->param('branch');
        my $error_message  = $cgi->param('error_message');
        my $op = $cgi->param('op') // '';
            my @ids = $cgi->param('ids');
    grep -- '\$input->param' tools/letter.pl
        my $searchfield = $input->param('searchfield');
        our $branchcode  = $input->param('branchcode');
        my $code        = $input->param('code');
        my $module      = $input->param('module') || '';
        my $content     = $input->param('content');
        my $op          = $input->param('op') || '';
            my $oldbranchcode = $input->param('oldbranchcode') || q||;
            my $branchcode = $input->param('branchcode') || q||;
            my $branchcode    = $input->param('branchcode') || '';
            my $module        = $input->param('module');
            my $oldmodule     = $input->param('oldmodule');
            my $code          = $input->param('code');
            my $name          = $input->param('name');
            my @mtt           = $input->param('message_transport_type');
            my @title         = $input->param('title');
            my @content       = $input->param('content');
                my $is_html = $input->param("is_html_$mtt");
    grep -- '\$input->param' tools/manage-marc-import.pl
        my $op = $input->param('op') || '';
        my $completedJobID = $input->param('completedJobID');
        our $runinbackground = $input->param('runinbackground');
        my $import_batch_id = $input->param('import_batch_id') || '';
        my $offset = $input->param('offset') || 0;
        my $results_per_page = $input->param('results_per_page') || 25; 
                my $framework = $input->param('framework');
            my $new_matcher_id = $input->param('new_matcher_id');
            my $current_matcher_id = $input->param('current_matcher_id');
            my $overlay_action = $input->param('overlay_action');
            my $nomatch_action = $input->param('nomatch_action');
            my $item_action = $input->param('item_action');
    grep -- '\$cgi->param' tools/marc_modification_templates.pl
        my $op = $cgi->param('op') || q{};
        my $template_id = $cgi->param('template_id');
          $template_id = '' unless $cgi->param('duplicate_current_template');
          $template_id = AddModificationTemplate( $cgi->param('template_name'), $template_id );
          my $mmta_id = $cgi->param('mmta_id');
          my $action = $cgi->param('action');
          my $field_number = $cgi->param('field_number');
          my $from_field = $cgi->param('from_field');
          my $from_subfield = $cgi->param('from_subfield');
          my $field_value = $cgi->param('field_value');
          my $to_field = $cgi->param('to_field');
          my $to_subfield = $cgi->param('to_subfield');
          my $to_regex_search = $cgi->param('to_regex_search');
          my $to_regex_replace = $cgi->param('to_regex_replace');
          my $to_regex_modifiers = $cgi->param('to_regex_modifiers');
          my $conditional = $cgi->param('conditional');
          my $conditional_field = $cgi->param('conditional_field');
          my $conditional_subfield = $cgi->param('conditional_subfield');
          my $conditional_comparison = $cgi->param('conditional_comparison');
          my $conditional_value = $cgi->param('conditional_value');
          my $conditional_regex = ( $cgi->param('conditional_regex') eq 'on' ) ? 1 : 0;
          my $description = $cgi->param('description');
          DelModificationTemplateAction( $cgi->param('mmta_id') );
          MoveModificationTemplateAction( $cgi->param('mmta_id'), $cgi->param('where') );
    grep -- '\$input->param' tools/modborrowers.pl
        my $op = $input->param('op') || 'show_form';
            my $filecontent    = $input->param('filecontent');
            my $patron_list_id = $input->param('patron_list_id');
                if ( my $list = $input->param('cardnumberlist') ) {
            my @disabled = $input->param('disable_input');
                my $value = $input->param($field);
            my @attributes = $input->param('patron_attributes');
            my @attr_values = $input->param('patron_attributes_value');
            my @borrowernumbers = $input->param('borrowernumber');
    grep -- '\$input->param' tools/newHolidays.pl
        our $branchcode          = $input->param('newBranchName');
        our $weekday             = $input->param('newWeekday');
        our $day                 = $input->param('newDay');
        our $month               = $input->param('newMonth');
        our $year                = $input->param('newYear');
        my $dateofrange         = $input->param('dateofrange');
        our $title               = $input->param('newTitle');
        our $description         = $input->param('newDescription');
        our $newoperation        = $input->param('newOperation');
        my $allbranches         = $input->param('allBranches');
            my @branchcodes = split(/\|/, $input->param('branchCodes')); 
    grep -- '\$input->param' tools/overduerules.pl
                    my $value = $input->param($key);
        my $type=$input->param('type');
        my $branch = $input->param('branch');
        my $op = $input->param('op');
            my @names=$input->param();
                            my $value = $input->param($key);
                                my @mtt = $input->param( "mtt${letternumber}-$bor" );
    grep -- '\$input->param' tools/picture-upload.pl
        my $filetype       = $input->param('filetype');
        my $cardnumber     = $input->param('cardnumber');
        my $uploadfilename = $input->param('uploadfile');
        my $borrowernumber = $input->param('borrowernumber');
        my $op             = $input->param('op') || '';
    grep -- '\$cgi->param' tools/quotes/quotes-upload_ajax.pl
        my $quotes = decode_json($cgi->param('quote'));
        my $action = $cgi->param('action');
    grep -- '\$input->param' tools/scheduler.pl
        my $mode = $input->param('mode');
        my $id   = $input->param('id');
            my $c4date = C4::Dates->new($input->param('startdate'));
            my $starttime = $input->param('starttime');
            my $report = $input->param('report');
            my $format = $input->param('format');
            my $email  = $input->param('email');
        #    my $recurring = $input->param('recurring');
        #        my $frequency = $input->param('frequency');
            my $jobid = $input->param('jobid');
            if ( $input->param('delete') ) {
    grep -- '\$input->param' tools/showdiffmarc.pl
        my $biblionumber = $input->param('id');
        my $importid     = $input->param('importid');
        my $batchid      = $input->param('batchid');
    grep -- '\$input->param' tools/stage-marc-import.pl
        my $fileID=$input->param('uploadedfileid');
        my $runinbackground = $input->param('runinbackground');
        my $completedJobID = $input->param('completedJobID');
        my $matcher_id = $input->param('matcher');
        my $overlay_action = $input->param('overlay_action');
        my $nomatch_action = $input->param('nomatch_action');
        my $parse_items = $input->param('parse_items');
        my $item_action = $input->param('item_action');
        my $comments = $input->param('comments');
        my $record_type = $input->param('record_type');
        my $encoding = $input->param('encoding');
        my $marc_modification_template = $input->param('marc_modification_template_id');
    grep -- '\$input->param' tools/upload-cover-image.pl
        my $fileID = $input->param('uploadedfileid');
        my $filetype       = $input->param('filetype');
        my $biblionumber   = $input->param('biblionumber');
        my $uploadfilename = $input->param('uploadfile');
          || $input->param('replace');
        my $op        = $input->param('op');
    grep -- '\$input->param' tools/viewlog.pl
        my $do_it    = $input->param('do_it');
        my @modules  = $input->param("modules");
        my $user     = $input->param("user");
        my @action   = $input->param("action");
        my $object   = $input->param("object");
        my $info     = $input->param("info");
        my $datefrom = $input->param("from");
        my $dateto   = $input->param("to");
        my $basename = $input->param("basename");
        my $output   = $input->param("output") || "screen";
        my $src      = $input->param("src"); # this param allows us to be told where we were called from -fbcit
    grep -- '\$query->param' virtualshelves/addbybiblionumber.pl
        our $shelfnumber     = $query->param('shelfnumber');
        our $newvirtualshelf = $query->param('newvirtualshelf');
        our $newshelf        = $query->param('newshelf');
        our $category        = $query->param('category');
        our $sortfield      = $query->param('sortfield');
        my $confirmed       = $query->param('confirmed') || 0;
            my @bib= $query->param('biblionumber');
            if(@bib==0 && $query->param('biblionumbers')) {
                my $str= $query->param('biblionumbers');
    grep -- '\$query->param' virtualshelves/downloadshelf.pl
        my $shelfid = $query->param('shelfid');
        my $format  = $query->param('format');
    grep -- '\$query->param' virtualshelves/sendshelf.pl
        my $shelfid = $query->param('shelfid');
        my $email   = $query->param('email');
            my $comment = $query->param('comment');

