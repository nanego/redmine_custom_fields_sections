class CustomFieldsSectionsController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :set_custom_fields_section, :only => %i[edit update destroy]

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

  private

  def custom_fields_section_params
    params.require(:custom_fields_section).permit(:name)
  end

  def set_custom_fields_section
    @custom_fields_section = CustomFieldsSection.find(params[:id])
  end
end
