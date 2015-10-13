React = require 'react'

module.exports = React.createClass
  displayName: 'ProjectStatistics'
  
  render: ->
    <div className="project-metadata">
      <h3 className="project-metadata-header"><span className="project-name">Diagnosis London</span> statistics</h3>
      {if @props.project?
        <div className="project-metadata-container">
          <section className="project-metadata-section">
            <span className="project-metadata-number">{@props.project.classifiers_count}</span>
            <span className="project-metadata-section-header">Active volunteers</span>
          </section>
          <section className="project-metadata-section">
            <span className="project-metadata-number">{@props.project.classifications_count}</span>
            <span className="project-metadata-section-header">Classifications</span>
          </section>
          <section className="project-metadata-section">
            <span className="project-metadata-number">{@props.project.subjects_count}</span>
            <span className="project-metadata-section-header">Pages</span>
          </section>
          {if @props.workflow?
            <section className="project-metadata-section">
              <span className="project-metadata-number">{@completion()}%</span>
              <span className="project-metadata-section-header">Complete</span>
            </section>}
        </div>
      }
    </div>
  
  completion: ->
    retired = @props.project.retired_subjects_count / @props.project.subjects_count
    activeCount = @props.project.subjects_count - @props.project.retired_subjects_count
    active = (@props.project.classifications_count / (activeCount * @props.workflow.retirement.options.count))
    ((retired + active) * 100).toFixed(0)