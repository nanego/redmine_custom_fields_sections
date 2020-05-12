class CustomFieldsSectionsController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :set_custom_fields_section, only: %i[edit update destroy order]

  def index
    @custom_fields_sections = CustomFieldsSection.all
  end

  def new
    @custom_fields_section = CustomFieldsSection.new
  end

  def create
    @custom_fields_section = CustomFieldsSection.new(custom_fields_section_params)

    if @custom_fields_section.save
      redirect_to custom_fields_sections_path
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @custom_fields_section.update(custom_fields_section_params)
      redirect_to custom_fields_sections_path
    else
      render "edit"
    end
  end

  def destroy
    @custom_fields_section.destroy

    redirect_to custom_fields_sections_path
  end

  def order
    fields = @custom_fields_section.project_custom_fields.sort
    position = params.require(:custom_fields_section).require(:position).to_i
    previous_position = fields.first.position

    if position > previous_position
      fields.reverse.each do |cf|
        cf.update(position: position + fields.index(cf))
      end
    else
      fields.each_with_index do |cf, i|
        cf.update(position: position + i)
      end
    end

    respond_to do |format|
      format.js { head 200 }
    end
  end

  private

  def custom_fields_section_params
    params.require(:custom_fields_section).permit(:name)
  end

  def set_custom_fields_section
    @custom_fields_section = CustomFieldsSection.find(params[:id])
  end
end
