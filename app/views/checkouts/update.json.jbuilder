if @form.errors.any?
  json.errors @form.errors
else
  json.summary render(partial: 'checkouts/summary',
                      formats: :html) if @form.is_step?(:delivery)
  json.confirm render(partial: 'checkouts/confirm',
                      formats: :html) if @form.is_step?(:payment)
  json.location orders_path if @form.complited?
end