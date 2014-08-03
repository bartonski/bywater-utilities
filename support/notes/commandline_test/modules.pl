#! /usr/bin/perl

use warnings;
use strict;
use lib '/home/barton/Support/git/koha';

my @modules = qw ( 
    misc::translator::LangInstaller misc::translator::TmplTokenizer misc::translator::VerboseWarnings OpenILS::QueryParser
    acqui::pdfformat::layout2pages acqui::pdfformat::layout3pages acqui::pdfformat::layout3pagesfr t::lib::Mocks
    t::Koha::Plugin::Test Koha::Filter::MARC::EmbedSeeFromHeadings Koha::Filter::MARC::Null Koha::Plugins::Handler
    Koha::Plugins::Base Koha::MetadataRecord Koha::SimpleMARC Koha::SearchEngine::Solr::QueryBuilder
    Koha::SearchEngine::Solr::FacetsBuilder Koha::SearchEngine::Solr::Config Koha::SearchEngine::Solr::Index Koha::SearchEngine::Solr::Search
    Koha::SearchEngine::Solr Koha::SearchEngine::QueryBuilder Koha::SearchEngine::FacetsBuilder Koha::SearchEngine::IndexRole
    Koha::SearchEngine::ConfigRole Koha::SearchEngine::Config Koha::SearchEngine::Index Koha::SearchEngine::Search
    Koha::SearchEngine::FacetsBuilderRole Koha::SearchEngine::QueryBuilderRole Koha::SearchEngine::Zebra::QueryBuilder Koha::SearchEngine::Zebra::Search
    Koha::SearchEngine::Zebra Koha::SearchEngine::SearchRole Koha::List::Patron Koha::Schema::Result::MarcSubfieldStructure
    Koha::Schema::Result::Systempreference Koha::Schema::Result::Reserveconstraint Koha::Schema::Result::Notify Koha::Schema::Result::Rating
    Koha::Schema::Result::TmpHoldsqueue Koha::Schema::Result::TagsIndex Koha::Schema::Result::TagsApproval Koha::Schema::Result::Accountline
    Koha::Schema::Result::Aqbudgetperiod Koha::Schema::Result::AqordersItem Koha::Schema::Result::AuthSubfieldStructure Koha::Schema::Result::Deletedborrower
    Koha::Schema::Result::Z3950server Koha::Schema::Result::OaiSet Koha::Schema::Result::LanguageScriptBidi Koha::Schema::Result::BorrowerFile
    Koha::Schema::Result::Subscription Koha::Schema::Result::BranchItemRule Koha::Schema::Result::OaiSetsBiblio Koha::Schema::Result::ImportItem
    Koha::Schema::Result::Item Koha::Schema::Result::OaiSetsMapping Koha::Schema::Result::ActionLog Koha::Schema::Result::ExportFormat
    Koha::Schema::Result::Patroncard Koha::Schema::Result::PrintersProfile Koha::Schema::Result::ReportsDictionary Koha::Schema::Result::Permission
    Koha::Schema::Result::Serial Koha::Schema::Result::Currency Koha::Schema::Result::MarcTagStructure Koha::Schema::Result::MatchpointComponent
    Koha::Schema::Result::Quote Koha::Schema::Result::MessageAttribute Koha::Schema::Result::TagAll Koha::Schema::Result::MarcMatcher
    Koha::Schema::Result::UserPermission Koha::Schema::Result::ItemCirculationAlertPreference Koha::Schema::Result::BorrowerMessageTransportPreference
    Koha::Schema::Result::HoldFillTarget Koha::Schema::Result::ClassSortRule Koha::Schema::Result::Deletedbiblio Koha::Schema::Result::OaiSetsDescription
    Koha::Schema::Result::AqordersTransfer Koha::Schema::Result::Ethnicity Koha::Schema::Result::AuthTagStructure
    Koha::Schema::Result::Tag Koha::Schema::Result::Biblioimage Koha::Schema::Result::BorrowerAttributeTypesBranch
    Koha::Schema::Result::Biblioitem Koha::Schema::Result::MessageQueue Koha::Schema::Result::BorrowerAttributeType
    Koha::Schema::Result::Deletedbiblioitem Koha::Schema::Result::Virtualshelve Koha::Schema::Result::AuthorisedValue
    Koha::Schema::Result::Review Koha::Schema::Result::Fieldmapping Koha::Schema::Result::Aqbasketgroup
    Koha::Schema::Result::Deleteditem Koha::Schema::Result::NeedMergeAuthority Koha::Schema::Result::Category
    Koha::Schema::Result::SavedReport Koha::Schema::Result::SavedSql Koha::Schema::Result::RepeatableHoliday Koha::Schema::Result::CreatorBatch
    Koha::Schema::Result::Printer Koha::Schema::Result::Subscriptionhistory Koha::Schema::Result::Aqbudgetborrower Koha::Schema::Result::DefaultBranchCircRule
    Koha::Schema::Result::Subscriptionroutinglist Koha::Schema::Result::Statistic Koha::Schema::Result::ClosureRrule Koha::Schema::Result::CreatorTemplate
    Koha::Schema::Result::Course Koha::Schema::Result::Linktracker Koha::Schema::Result::Virtualshelfshare Koha::Schema::Result::City
    Koha::Schema::Result::ActionLogs Koha::Schema::Result::ImportBatch Koha::Schema::Result::PendingOfflineOperation Koha::Schema::Result::MarcModificationTemplateAction
    Koha::Schema::Result::Branchcategory Koha::Schema::Result::LanguageRfc4646ToIso639 Koha::Schema::Result::Alert Koha::Schema::Result::DefaultBorrowerCircRule
    Koha::Schema::Result::AqbudgetsPlanning Koha::Schema::Result::Biblio Koha::Schema::Result::Nozebra Koha::Schema::Result::Branchtransfer
    Koha::Schema::Result::SubscriptionNumberpattern Koha::Schema::Result::Overduerule Koha::Schema::Result::BorrowerDebarment Koha::Schema::Result::Branchrelation
    Koha::Schema::Result::Suggestion Koha::Schema::Result::Userflag Koha::Schema::Result::BorrowerModification Koha::Schema::Result::Aqorder
    Koha::Schema::Result::MessageTransportType Koha::Schema::Result::Letter Koha::Schema::Result::Aqbasketuser Koha::Schema::Result::TransportCost
    Koha::Schema::Result::Zebraqueue Koha::Schema::Result::SearchHistory Koha::Schema::Result::Message Koha::Schema::Result::ClassSource
    Koha::Schema::Result::MatchpointComponentNorm Koha::Schema::Result::DefaultBranchItemRule Koha::Schema::Result::Matchpoint Koha::Schema::Result::Borrower
    Koha::Schema::Result::CategoriesBranch Koha::Schema::Result::SocialData Koha::Schema::Result::OldReserve Koha::Schema::Result::Roadtype
    Koha::Schema::Result::ServicesThrottle Koha::Schema::Result::CourseReserve Koha::Schema::Result::CreatorImage Koha::Schema::Result::LanguageSubtagRegistry
    Koha::Schema::Result::BiblioFramework Koha::Schema::Result::Virtualshelfcontent Koha::Schema::Result::Aqcontract Koha::Schema::Result::OpacNews
    Koha::Schema::Result::Aqorderdelivery Koha::Schema::Result::AuthHeader Koha::Schema::Result::MatcherMatchpoint Koha::Schema::Result::OldIssue
    Koha::Schema::Result::Accountoffset Koha::Schema::Result::Branch Koha::Schema::Result::ImportBiblio Koha::Schema::Result::AuthorisedValuesBranch
    Koha::Schema::Result::Session Koha::Schema::Result::Matchcheck Koha::Schema::Result::BorrowerAttribute Koha::Schema::Result::ImportRecord
    Koha::Schema::Result::Aqbudget Koha::Schema::Result::BranchBorrowerCircRule Koha::Schema::Result::Closure Koha::Schema::Result::Aqinvoice
    Koha::Schema::Result::CourseInstructor Koha::Schema::Result::Aqbookseller Koha::Schema::Result::Patronimage Koha::Schema::Result::Stopword
    Koha::Schema::Result::Browser Koha::Schema::Result::MarcModificationTemplate Koha::Schema::Result::BorrowerMessagePreference Koha::Schema::Result::SpecialHoliday
    Koha::Schema::Result::Issuingrule Koha::Schema::Result::CourseItem Koha::Schema::Result::CreatorLayout Koha::Schema::Result::PluginData
    Koha::Schema::Result::AuthType Koha::Schema::Result::PatronList Koha::Schema::Result::Aqbasket Koha::Schema::Result::Issue
    Koha::Schema::Result::CollectionTracking Koha::Schema::Result::Itemtype Koha::Schema::Result::Serialitem Koha::Schema::Result::SubscriptionFrequency
    Koha::Schema::Result::LanguageDescription Koha::Schema::Result::MessageTransport Koha::Schema::Result::DefaultCircRule Koha::Schema::Result::Reserve
    Koha::Schema::Result::ImportAuth Koha::Schema::Result::BranchTransferLimit Koha::Schema::Result::Collection Koha::Schema::Result::LanguageScriptMapping
    Koha::Schema::Result::PatronListPatron Koha::Schema::Result::ImportRecordMatches Koha::Schema Koha::SuggestionEngine::Base
    Koha::SuggestionEngine::Plugin::ExplodedTerms Koha::SuggestionEngine::Plugin::Null Koha::SuggestionEngine::Plugin::AuthorityFile Koha::RecordProcessor
    Koha::Linktracker Koha::SearchEngine Koha::Calendar Koha::Plugins
    Koha::Borrower::Files Koha::Borrower::Debarments Koha::Borrower::Modifications Koha::Util::MARC
    Koha::Cache Koha::QueryParser::Driver::PQF Koha::QueryParser::Driver::PQF::query_plan Koha::QueryParser::Driver::PQF::query_plan::modifier
    Koha::QueryParser::Driver::PQF::query_plan::node Koha::QueryParser::Driver::PQF::query_plan::facet Koha::QueryParser::Driver::PQF::query_plan::filter Koha::QueryParser::Driver::PQF::query_plan::node::atom
    Koha::QueryParser::Driver::PQF::Util Koha::Template::Plugin::KohaDates Koha::Template::Plugin::EncodeUTF8 Koha::Template::Plugin::ItemTypes
    Koha::Template::Plugin::Koha Koha::Template::Plugin::Cache Koha::Template::Plugin::Branches Koha::Template::Plugin::AuthorisedValues
    Koha::Indexer::Utils Koha::SuggestionEngine Koha::AuthUtils Koha::RecordProcessor::Base
    Koha::Cache::Object Koha::Authority Koha::Database Koha::DateUtils
    C4::SQLHelper C4::Auth_with_ldap C4::Templates C4::Reports::Guided
    C4::Serials::Numberpattern C4::Serials::Frequency C4::ItemType C4::Reserves
    C4::Matcher C4::Reports C4::Search::PazPar2 C4::SMS
    C4::Bookseller C4::Ris C4::Input C4::Output::JSONStream
    C4::ShelfBrowser C4::Record C4::Log C4::Output
    C4::Linker C4::Serials C4::RotatingCollections C4::Boolean
    C4::Scheduler C4::Heading::MARC21 C4::Heading::UNIMARC C4::TmplToken
    C4::Budgets C4::ItemCirculationAlertPreference C4::Creators C4::Heading
    C4::Overdues C4::Debug C4::Review C4::Category
    C4::XISBN C4::Patroncards C4::Languages C4::Labels::Label
    C4::Labels::Layout C4::Labels::Template C4::Labels::Profile C4::Labels::Batch
    C4::ClassSortRoutine::Dewey C4::ClassSortRoutine::LCC C4::ClassSortRoutine::Generic C4::NewsChannels
    C4::Csv C4::CourseReserves C4::Linker::FirstMatch C4::Linker::LastMatch
    C4::Linker::Default C4::MarcModificationTemplates C4::ImportBatch C4::HoldsQueue
    C4::Circulation C4::OAI::Sets C4::Tags C4::Biblio
    C4::Images C4::Items C4::Letters C4::Calendar
    C4::HTML5Media C4::Search C4::Breeding C4::AuthoritiesMarc::MARC21
    C4::AuthoritiesMarc::UNIMARC C4::Installer C4::Ratings C4::Contract
    C4::Message C4::VirtualShelves::Merge C4::VirtualShelves::Page C4::VirtualShelves
    C4::ClassSource C4::Context C4::TTParser C4::Form::MessagingPreferences
    C4::Koha C4::External::Syndetics C4::External::Amazon C4::External::OverDrive
    C4::External::BakerTaylor C4::SocialData C4::ILSDI::Services C4::Barcodes::annual
    C4::Barcodes::ValueBuilder C4::Barcodes::PrinterConfig C4::Barcodes::incremental C4::Barcodes::hbyymmincr
    C4::Barcodes::EAN13 C4::Maintainance C4::ImportExportFramework C4::Scrubber
    C4::UploadedFile C4::AuthoritiesMarc C4::Barcodes C4::Branch
    C4::Creators::Lib C4::Creators::Layout C4::Creators::Template C4::Creators::Profile
    C4::Creators::Batch C4::Creators::PDF C4::Accounts C4::Print
    C4::Utils::DataTables C4::Stats C4::SIP::SIPServer C4::SIP::t::SIPtest
    C4::SIP::Sip::Constants C4::SIP::Sip::Configuration C4::SIP::Sip::Checksum C4::SIP::Sip::Configuration::Institution
    C4::SIP::Sip::Configuration::Account C4::SIP::Sip::Configuration::Service C4::SIP::Sip::MsgType C4::SIP::Sip
    C4::SIP::ILS C4::SIP::ILS::Patron C4::SIP::ILS::Item C4::SIP::ILS::Transaction
    C4::SIP::ILS::Transaction::RenewAll C4::SIP::ILS::Transaction::Checkin C4::SIP::ILS::Transaction::FeePayment C4::SIP::ILS::Transaction::Renew
    C4::SIP::ILS::Transaction::Hold C4::SIP::ILS::Transaction::Checkout C4::BackgroundJob C4::Members::Statistics
    C4::Members::Attributes C4::Members::AttributeTypes C4::Members::Messaging C4::Dates
    C4::Labels C4::XSLT C4::Members C4::ClassSortRoutine
    C4::Charset C4::TmplTokenType C4::Auth C4::Auth_with_cas
    C4::Installer::PerlModules C4::Installer::PerlDependencies C4::Suggestions C4::Service
    C4::Patroncards::Lib C4::Patroncards::Patroncard C4::Patroncards::Layout C4::Patroncards::Template
    C4::Patroncards::Profile C4::Patroncards::Batch C4::Acquisition installer::InstallAuth
    install_misc::UpgradeBackup
); 

for my $module ( @modules ) {
    require $module;
    print "$module : '" . join( ' ', @$module::EXPORT ) . "'\n";
}
