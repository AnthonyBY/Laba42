# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  permit_params :name, :email, :role, :skills, :phone_number, :company_name, :info

  filter :projects
  filter :applies
  filter :applied_to_projects
  filter :name
  filter :info
  filter :email
  filter :phone_number
  filter :company_name
  filter :role, as: :select, collection: User::USER_ROLES

  index do
    column :id
    column :name do |user|
      link_to(user.name, admin_user_path(user))
    end
    column :email
    column :info do |user|
      simple_format user.info.truncate(80)
    end
    column :skills, as: :text
    column :role
    column :phone_number
    column :company_name

    actions
  end

  show do
    attributes_table do
      row :id
      row :name do |user|
        link_to(user.name, admin_user_path(user))
      end
      row :email
      row :info do |user|
        simple_format user.info.truncate(80)
      end
      row :skills, as: :text
      row :role
      row :applies do |user|
        user.applies.map { |apply| link_to(apply.project.title, admin_project_path(apply.project)) }
      end
      row :phone_number
      row :company_name
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'User' do
      input :name
      input :email
      input :info, as: :text
      input :skills, as: :text
      input :role
      input :phone_number
      input :company_name
    end

    f.para 'Press cancel to return to the list without saving.'
    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
