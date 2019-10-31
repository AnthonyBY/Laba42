# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Project do
  permit_params :title, :user, :info, :skills, :project_type, :cost, :status, :employee, :deadline

  scope :status_active
  scope :status_notification_sent
  scope :status_completed
  scope :status_favorite

  scope :project_type
  scope :test_type

  controller do
    def scoped_collection
      Project.includes(:user) unless params[:action] == 'destroy'
    end

    def destroy
      Project.find_by(id: params[:id]).destroy
      redirect_to collection_url
    end
  end

  index do
    column :id
    column :title do |pr|
      link_to(pr.title, admin_project_path(pr))
    end
    column :user
    column :info do |pr|
      simple_format pr.info.truncate(80)
    end
    column :skills
    column :project_type
    column :cost
    column :status
    column :employee
    column :deadline
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :user
      row :info do |pr|
        div do
          simple_format pr.info
        end
      end
      row :skills
      row :project_type
      row :cost
      row :status
      row :employee
      row :deadline
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Discount perk' do
      input :title
      input :user
      input :info, as: :text
      input :skills, as: :string
      input :project_type
      input :cost
      input :status
      input :employee, label: 'Employeee', as: :select,
                       collection: User.all.map { |user| [user.name, user.id] } << ['0', 0], required: true
      input :deadline, as: :datepicker
    end

    f.para 'Press cancel to return to the list without saving.'
    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
