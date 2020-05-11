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

  def edit
    first_position = 0

    @custom_fields_section.project_custom_fields.sort.each_with_index do |cf, i|
      first_position = cf.position if i == 0

      cf.update(position: first_position + i)
    end
  end

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
    position = params.require(:custom_fields_section).require(:position)

    fields.reverse.each do |cf|
      cf.update(position: position.to_i + fields.index(cf))
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
