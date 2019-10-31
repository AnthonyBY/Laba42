# frozen_string_literal: true

ActiveAdmin.register Apply do
  permit_params :user, :project, :apply_status
end
