$("#p11n_<%= @eid %>_<%= @uid %>").html("<%= escape_javascript(render partial: 'p11n', locals: { is_relation: true, eid: @eid, uid: @uid }) %>")