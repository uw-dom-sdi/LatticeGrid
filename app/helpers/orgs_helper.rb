module OrgsHelper
  def org_nav_heading()
    out="<span id='nav_links'>"
    if not (controller.action_name == 'show_investigators' and controller.controller_name == 'orgs')
      out+= link_to('Investigators', show_investigators_org_url(:id=>params[:id]) ) 
      out+= " &nbsp;  &nbsp; " 
    end
    if not (controller.action_name == 'show' and controller.controller_name == 'orgs')
      out+= link_to('Publications', show_org_url(:id=>params[:id], :page=>1) ) 
      out+= " &nbsp;  &nbsp; " 
    end
    if not (controller.action_name == 'show_org' and controller.controller_name == 'graphs')
      out+= link_to('Co-authorship graph', show_org_graph_url(params[:id]) ) 
      out+= " &nbsp;  &nbsp; " 
    end
    if not (controller.action_name == 'show_org' and controller.controller_name == 'graphviz')
      out+= link_to( "Co-authorship network", show_org_graphviz_url(params[:id]) )
      out+= " &nbsp;  &nbsp; " 
    end
    if not (controller.action_name == 'show_org_mesh' and controller.controller_name == 'graphviz')
      out+= link_to( "Similarity network", show_org_mesh_graphviz_url(params[:id]))
      out+= " &nbsp;  &nbsp; "  
    end
    if not (controller.action_name == 'show_org_org' and controller.controller_name == 'graphviz')
      out+= link_to( "Unit-to-Unit network", show_org_org_graphviz_url(params[:id]))
      out+= " &nbsp;  &nbsp; "  
    end
    if not (controller.action_name == 'program_chord' and controller.controller_name == 'cytoscape')
      out+= link_to( "Chord diagram", program_chord_cytoscape_url(params[:id]))
      out+= " &nbsp;  &nbsp; "  
    end
    if not (controller.action_name == 'chord' and controller.controller_name == 'cytoscape')
      out+= link_to( "Unit-to-Unit Chord", chord_cytoscape_url )
      out+= " &nbsp;  &nbsp; "  
    end
    out+="<br/>Radial Graphs: "
    if not (controller.action_name == 'show_org' and controller.controller_name == 'cytoscape')
      out+= link_to( "Publications network", show_org_cytoscape_url(params[:id]) )
      out+= " &nbsp;  &nbsp; " 
    end
    if defined?(LatticeGridHelper.include_awards?) and LatticeGridHelper.include_awards?() then
      if not (controller.action_name == 'awards_org' and controller.controller_name == 'cytoscape')
        out+= link_to('Funding network', awards_org_cytoscape_url(params[:id]) ) 
      else
        out+= "<span class='disabled'>Funding network</span>"      
      end
      out+= " &nbsp;  &nbsp; " 
      if not (controller.action_name == 'org' and controller.controller_name == 'awards')
        out+= link_to('Funding report', org_award_url(:id=>params[:id], :page=>1) ) 
        out+= " &nbsp;  &nbsp; " 
      else
        out+= "<span class='disabled'>Funding report</span>"      
      end
      out+= " &nbsp;  &nbsp; " 
    end
    if defined?(LatticeGridHelper.include_studies?) and LatticeGridHelper.include_studies?() then
      if not (controller.action_name == 'studies_org' and controller.controller_name == 'cytoscape')
        out+= link_to( "Studies network", studies_org_cytoscape_url(params[:id]) )
        out+= " &nbsp;  &nbsp; " 
      else
        out+= "<span class='disabled'>Studies network</span>"      
      end
      if not (controller.action_name == 'org' and controller.controller_name == 'studies')
        out+= link_to('Studies report', org_study_url(:id=>params[:id], :page=>1) ) 
        out+= " &nbsp;  &nbsp; " 
      else
         out+= "<span class='disabled'>Studies report</span>"      
      end
    end
    if defined?(LatticeGridHelper.include_studies?) and LatticeGridHelper.include_studies?() and defined?(LatticeGridHelper.include_awards?) and LatticeGridHelper.include_awards?() then
       if not (controller.action_name == 'org_all' and controller.controller_name == 'cytoscape')
        out+= link_to( "Combined network", org_all_cytoscape_url(params[:id]) )
        out+= " &nbsp;  &nbsp; " 
      end
    end
    out+"</span>"
  end
  
  def find_unit_by_id_or_name(val)
    unit = OrganizationalUnit.find_by_abbreviation(val)
    if unit.blank?
      unit = OrganizationalUnit.find_by_name(val)
    end
    if unit.blank?
      unit = OrganizationalUnit.find_by_search_name(val)
    end
    if unit.blank?
      unit = OrganizationalUnit.find_by_id(val)
    end
    if unit.blank?
      unit = OrganizationalUnit.find_by_division_id(val)
    end
    unit
  end
  
  def get_orgs(id)
    ids=id.split(",")
    if ids.length > 1
      OrganizationalUnit.find(:all, :conditions => ["id in (:ids)", {:ids=>ids }])
    else
      OrganizationalUnit.find_all_by_id(id)
    end
  end
  
end