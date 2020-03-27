import UIKit

final class AddCityTableViewCell: UITableViewCell {
  // MARK: - Properties -
  static let reuseIdentifier = String(describing: AddCityTableViewCell.self)
  var city: City? {
    didSet {
      cityLabelName.text = "\(city?.name ?? ""), \(city?.country ?? "")"
      descriptionWeatherLabel.text = city?.iconStatus.first?.description
      temperatureLabel.text = "\(city?.weather.temperature.convertKelvinToCelsius() ?? 0)°C"
    }
  }
  private let containerStackView = UIStackView()
  private let cityNameStackView = UIStackView()

  private let cityLabelName: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()

  private let descriptionWeatherLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()

  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = Colors.text
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .left
    return label
  }()
// MARK: - Initializers -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
// MARK: - Set Up Views -
  private func setUpView() {
    addSubview(cityNameStackView)
    backgroundColor = Colors.clear
    // TODO: - fix layout
    setUpCityNameStackView()
  }

  private func setUpCityNameStackView() {
    cityNameStackView.distribution = .equalSpacing
    cityNameStackView.axis = .horizontal
    cityNameStackView.spacing = 5
    cityNameStackView.addArrangedSubview(cityLabelName)
    cityNameStackView.addArrangedSubview(descriptionWeatherLabel)
    cityNameStackView.addArrangedSubview(temperatureLabel)
    cityNameStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        cityNameStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
        cityNameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
        cityNameStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
        cityNameStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0)
    ])
  }
}
