import UIKit

final class CityTableViewCell: UITableViewCell {
  // MARK: - Properties
  var city: City? {
    didSet {
      cityLabelName.text = "\(city?.name ?? "") ,\(city?.weatherTime.country ?? "")"
      descriptionWeatherLabel.text = city?.iconStatus.first?.description
      countryLabel.text = city?.weatherTime.country
      temperatureLabel.text = "\(city?.weather.temperature.convertKelvinToCelsius() ?? 0)°C"
    }
  }
  private let containerStackView = UIStackView()
  private let cityNameStackView = UIStackView()

  private let cityLabelName: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()

  private let countryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()

  private let descriptionWeatherLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()

  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()
// MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(containerStackView)
    setUpContainerStackView()
    setUpCityNameStackView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
// MARK: - Set Up Views
  private func setUpContainerStackView() {
    containerStackView.axis = .vertical
    containerStackView.spacing = 5
    containerStackView.addArrangedSubview(cityNameStackView)
    containerStackView.addArrangedSubview(temperatureLabel)
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
      containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
    ])
  }

  private func setUpCityNameStackView() {
    cityNameStackView.distribution = .equalSpacing
    cityNameStackView.axis = .horizontal
    cityNameStackView.spacing = 5
    cityNameStackView.addArrangedSubview(cityLabelName)
    cityNameStackView.addArrangedSubview(descriptionWeatherLabel)
    cityNameStackView.addArrangedSubview(countryLabel)
    cityNameStackView.translatesAutoresizingMaskIntoConstraints = false
  }
}
