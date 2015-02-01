#! /usr/bin/perl

# Takes a SIP message from STDIN, and dumps the message, with labels as YAML.
use warnings;
use strict;
use YAML;

sub read_fixed_width_fields {
    my ( $field, @subfield_layouts ) = @_;
    my @subfield_data = ();
    my $unpack_template = '';
    my $subfield_arrayref = [];
    for my $subfield_layout ( @subfield_layouts ) {
        $unpack_template .= $subfield_layout->{pack_template} . $subfield_layout->{length};
    }
    @subfield_data = unpack( $unpack_template, $field );
    for my $index ( 0 .. scalar( @subfield_layouts ) - 1 ) {
        my $subfield_layout = $subfield_layouts[ $index ];
        push( @{$subfield_arrayref}, { $subfield_layout->{field_name}, $subfield_data[$index] } );
    }

    return $subfield_arrayref;
}

sub read_sip_record {
    my ( $record, $format ) = @_;
    my $sip_hashref = {};
    $sip_hashref->{command_name} = $format->{command_name};
    $sip_hashref->{ fields } = [];
    my @sip_fields = split ( '\|', $record );
    for my $index ( 0 .. scalar( @sip_fields ) - 1 ) {
        my $sip_field = $sip_fields[$index];
        my $sip_field_structure = $format->{structure}->[$index];
        if ( defined $sip_field_structure->{fixed_width_fields}) {
            # read fixed width fields
            my $fixed_width_fields = read_fixed_width_fields( $sip_field, @{$sip_field_structure->{fixed_width_fields} } );
            push ( @{ $sip_hashref->{ fields } }, { $sip_field_structure->{field_name}, $fixed_width_fields } );
        } else {
            push ( @{ $sip_hashref->{ fields } }, { $sip_field_structure->{field_name}, $sip_field }  );
        }
    }
    return $sip_hashref;
}

my $sip_format = {
      11 => {
          command_name => 'Checkout'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'           , pack_template => 'A',  length        => 2   }
                    , { field_name => 'SC renewal policy'    , pack_template => 'A' , length        => 1   }
                    , { field_name => 'no block'             , pack_template => 'A' , length        => 1   }
                    , { field_name => 'Transaction Year'     , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Transaction Month'    , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Day'      , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Timezone' , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Transaction Hour'     , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Minute'   , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Second'   , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Due Year'             , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Due Month'            , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Due Day'              , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Due Timezone'         , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Due Hour'             , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Due Minute'           , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Due Second'           , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Institution id'       , pack_template => 'A' , length        => '*' }
                ]
            }
            , { field_name => 'Patron identifier'    }
            , { field_name => 'Item identifier'      }
            , { field_name => 'Terminal password'    }
            , { field_name => 'item properties'      }
            , { field_name => 'patron password'      }
            , { field_name => 'Trialer'
                  , fixed_width_fields => [
                      { field_name => 'Fee acknowledged'     , pack_template => 'A'  , length => 1 }
                    , { field_name => 'Cancel'               , pack_template => 'A'  , length => 1 }
                  ]
              }
          ]
    }
    , 12 => {
          command_name => 'Checkout Response'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'           , pack_template => 'A',  length        => 2   }
                    , { field_name => 'OK'    , pack_template => 'A' , length        => 1   }
                    , { field_name => 'Renewal OK'             , pack_template => 'A' , length        => 1   }
                    , { field_name => 'Magnetic media'             , pack_template => 'A' , length        => 1   }
                    , { field_name => 'Desensitize'             , pack_template => 'A' , length        => 1   }
                    , { field_name => 'Transaction Year'     , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Transaction Month'    , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Day'      , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Timezone' , pack_template => 'A' , length        => 4   }
                    , { field_name => 'Transaction Hour'     , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Minute'   , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Transaction Second'   , pack_template => 'A' , length        => 2   }
                    , { field_name => 'Institution id'       , pack_template => 'A' , length        => '*' }
                ]
            }
            , { field_name => 'Patron identifier'    }
            , { field_name => 'Item identifier'      }
            , { field_name => 'Title identifier'     }
            , { field_name => 'Due date'             }
            , { field_name => 'Fixed width 1'
                  , fixed_width_fields => [
                      { field_name => 'Fee type'             , pack_template => 'A'  , length => 2 }
                    , { field_name => 'Security inhibit'     , pack_template => 'A'  , length => 1 }
                    , { field_name => 'currency type'        , pack_template => 'A'  , length => 3 }
                    , { field_name => 'Fee aount'            , pack_template => 'A'  , length => '*' }
                  ]
              }
            , { field_name => 'Fixed width 2'
                  , fixed_width_fields => [
                      { field_name => 'media type'           , pack_template => 'A'  , length => 3 }
                    , { field_name => 'Item properties'      , pack_template => 'A'  , length => '*' }
                  ]
              }
            , { field_name => 'Transaction ID'             }
            , { field_name => 'Screen message'             }
            , { field_name => 'Print line'                 }
          ]
    }
    , '09' => {
          command_name => 'Checkin'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                  { field_name => 'Command ID'           , pack_template => 'A',  length => 2   }
                , { field_name => 'no block'             , pack_template => 'A' , length => 1   }
                , { field_name => 'Transaction Year'     , pack_template => 'A' , length => 4   }
                , { field_name => 'Transaction Month'    , pack_template => 'A' , length => 2   }
                , { field_name => 'Transaction Day'      , pack_template => 'A' , length => 2   }
                , { field_name => 'Transaction Timezone' , pack_template => 'A' , length => 4   }
                , { field_name => 'Transaction Hour'     , pack_template => 'A' , length => 2   }
                , { field_name => 'Transaction Minute'   , pack_template => 'A' , length => 2   }
                , { field_name => 'Transaction Second'   , pack_template => 'A' , length => 2   }
                , { field_name => 'Return Year'          , pack_template => 'A' , length => 4   }
                , { field_name => 'Return Month'         , pack_template => 'A' , length => 2   }
                , { field_name => 'Return Day'           , pack_template => 'A' , length => 2   }
                , { field_name => 'Return Timezone'      , pack_template => 'A' , length => 4   }
                , { field_name => 'Return Hour'          , pack_template => 'A' , length => 2   }
                , { field_name => 'Return Minute'        , pack_template => 'A' , length => 2   }
                , { field_name => 'Return Second'        , pack_template => 'A' , length => 2   }
                , { field_name => 'Current location'     , pack_template => 'A' , length => '*' }
              ]
            }
            , { field_name => 'Institution id'       }
            , { field_name => 'Item identifier'      }
            , { field_name => 'Terminal password'    }
            , { field_name => 'item properties'      }
            , { field_name => 'Trialer'
                  , fixed_width_fields => [
                     { field_name => 'Cancel'               , pack_template => 'A'  , length => 1 }
                  ]
            }
          ]
    }
    , 10 => {
          command_name => 'Checkin Response'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'           , pack_template => 'A',  length => 2   }
                    , { field_name => 'OK'                   , pack_template => 'A' , length => 1   }
                    , { field_name => 'Resensitize'          , pack_template => 'A' , length => 1   }
                    , { field_name => 'Magnetic media'       , pack_template => 'A' , length => 1   }
                    , { field_name => 'Alert'                , pack_template => 'A' , length => 1   }
                    , { field_name => 'Transaction Year'     , pack_template => 'A' , length => 4   }
                    , { field_name => 'Transaction Month'    , pack_template => 'A' , length => 2   }
                    , { field_name => 'Transaction Day'      , pack_template => 'A' , length => 2   }
                    , { field_name => 'Transaction Timezone' , pack_template => 'A' , length => 4   }
                    , { field_name => 'Transaction Hour'     , pack_template => 'A' , length => 2   }
                    , { field_name => 'Transaction Minute'   , pack_template => 'A' , length => 2   }
                    , { field_name => 'Transaction Second'   , pack_template => 'A' , length => 2   }
                    , { field_name => 'Institution id'       , pack_template => 'A' , length => '*' }
                ]
            }
            , { field_name => 'Item identifier'      }
            , { field_name => 'Permanent location'   }
            , { field_name => 'Title identifier'     }
            , { field_name => 'Sort bin'             }
            , { field_name => 'Patron identifier'    }
            , { field_name => 'Fixed width 1'
                  , fixed_width_fields => [
                      { field_name => 'Media type'           , pack_template => 'A'  , length => 3   }
                    , { field_name => 'Item properties'      , pack_template => 'A'  , length => '*' }
                  ]
              }
            , { field_name => 'Screen message'             }
            , { field_name => 'Print line'                 }
          ]
    }
# 17
    , 17 => {
          command_name => 'Item information'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'        , pack_template => 'A' , length => 2  }
                    , { field_name => 'Transaction date'  , pack_template => 'A' , length => 18  }
                    , { field_name => 'Institution ID'    , pack_template => 'A' , length => '*'  }
                  ]
              ,
            }   
            , { field_name => 'Item identifier' }
            , { field_name => 'Terminal password' }
          ]
    }

# 29
    , 29 => {
          command_name => 'Renew'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'          , pack_template => 'A' , length => 2  }
                    , { field_name => 'Third party allowed' , pack_template => 'A' , length => 1  }
                    , { field_name => 'No block'            , pack_template => 'A' , length => 1  }
                    , { field_name => 'Transaction date'    , pack_template => 'A' , length => 18  }
                    , { field_name => 'NB due date'         , pack_template => 'A' , length => 18  }
                    , { field_name => 'Institution ID'      , pack_template => 'A' , length => '*'  }
                  ]
              ,
            }   
            , { field_name => 'Patron idenfifier' }
            , { field_name => 'Patron password' }
            , { field_name => 'Item identifier' }
            , { field_name => 'Title identifier' }
            , { field_name => 'Terminal password' }
            , { field_name => 'item properties' }
            , { field_name => 'Fee Acknowledged' }
          ]
    }

# 35
    , 63 => {
          command_name => 'Patron Information'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'        , pack_template => 'A' , length => 2  }
                    , { field_name => 'Language'          , pack_template => 'A' , length => 3  }
                    , { field_name => 'Transaction date'  , pack_template => 'A' , length => 18  }
                    , { field_name => 'Summary'           , pack_template => 'A' , length => 10  }
                  ]
              ,
            }   
            , { field_name => 'Institution ID'    }
            , { field_name => 'Patron identifier' }
            , { field_name => 'Terminal password' }
            , { field_name => 'Patron password'   }
            , { field_name => 'Start item'        }
            , { field_name => 'End item'          }
          ]
    }
    , 93 => {
          command_name => 'Login'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                      { field_name => 'Command ID'           , pack_template => 'A' , length => 2  }
                    , { field_name => 'UID algorithm'        , pack_template => 'A' , length => 1  }
                    , { field_name => 'PWD algorithm'        , pack_template => 'A' , length => 1  }
                    , { field_name => 'Login user ID'        , pack_template => 'A' , length => '*'  }
                  ]
            }   
            , { field_name => 'Login password'            }
            , { field_name => 'Location code'             }
          ]
    }
    , 99 => {
          command_name => 'SC Status'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                  { field_name => 'Command ID'           , pack_template => 'A' , length => 2  }
                , { field_name => 'Status code'          , pack_template => 'A' , length => 1  }
                , { field_name => 'Max print width'      , pack_template => 'A' , length => 3  }
                , { field_name => 'Protocol version'     , pack_template => 'A' , length => 4  }
              ]
            }
          ]
    }
    , 97 => { 
          command_name => 'Request ACS Resend'
        , structure => [
            {   field_name => 'Header'
              , fixed_width_fields => [
                  { field_name => 'Command ID'         , pack_template => 'A', length => 2  }
                ]
            }
          ]
    }
};

while ( <> ) {
    chomp;
    my $sip_id = substr( $_, 0, 2 );
    my $field_info = $sip_format->{ $sip_id };
    if( $field_info ) {
        print "Sip record:\n";
        print "$_\n";
        print YAML::Dump( read_sip_record ($_, $field_info) );
    }
}
